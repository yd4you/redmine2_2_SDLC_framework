class WorkTimeController < ApplicationController
  unloadable
  #  before_filter :find_project, :authorize

  helper :custom_fields
  include CustomFieldsHelper

  NO_ORDER = -1

  def index
    @message = ""
    require_login || return
    @project = nil
    prepare_values
    ticket_pos
    prj_pos
    ticket_del
    hour_update
    make_pack
    update_daily_memo
    set_holiday
    @custom_fields = TimeEntryCustomField.find(:all)
    @link_params.merge!(:action=>"index")
    if !params.key?(:user) then
      redirect_to @link_params
    else
      render "show"
    end
  end

  def show
    @message = ""
    require_login || return
    find_project
    authorize
    prepare_values
    ticket_pos
    prj_pos
    ticket_del
    hour_update
    make_pack
    member_add_del_check
    update_daily_memo
    set_holiday
    @custom_fields = TimeEntryCustomField.find(:all)
    @link_params.merge!(:action=>"show")
    if !params.key?(:user) then
      redirect_to @link_params
    end
  end

  def member_monthly_data
    require_login || return
    if params.key?(:id) then
      find_project
    end
    prepare_values
    make_pack

    csv_data = "\"user\",\"date\",\"project\",\"ticket\",\"spend time\"\n"

    (@first_date..@last_date).each do |date|
      @month_pack[:odr_prjs].each do |prj_pack|
        next if prj_pack[:count_issues] == 0
        prj_pack[:odr_issues].each do |issue_pack|
          next if issue_pack[:count_hours] == 0
          issue = issue_pack[:issue]
          if issue_pack[:total_by_day][date] then
            csv_data << "\"#{@this_user}\",\"#{date}\",\"#{issue.project}\",\"#{issue.subject}\",#{issue_pack[:total_by_day][date]}\n"
          end
        end
      end
      if @month_pack[:other_by_day].has_key?(date) then
        csv_data << "\"#{@this_user}\",\"#{date}\",\"PRIVATE\",\"PRIVATE\",#{@month_pack[:other_by_day][date]}\n"
      end
    end
    send_data Redmine::CodesetUtil.from_utf8(csv_data, l(:general_csv_encoding)), :type=>"text/csv", :filename=>"member_monthly.csv"
  end

  def total
    @message = ""
    find_project
    authorize
    prepare_values
    add_ticket_relay
    change_member_position
    change_ticket_position
    change_project_position
    member_add_del_check
    calc_total
    @link_params.merge!(:action=>"total")
  end

  def total_data
    find_project
    authorize
    prepare_values
    add_ticket_relay
    change_member_position
    change_ticket_position
    change_project_position
    member_add_del_check
    calc_total
    
    csv_data = "\"user\",\"relayed project\",\"relayed ticket\",\"project\",\"ticket\",\"spend time\"\n"
    #-------------------------------------- ã¡ã³ããEã®ã«ã¼ãE
    @members.each do |mem_info|
      user = mem_info[1]

      #-------------------------------------- ãã­ã¸ã§ã¯ããEã«ã¼ãE
      prjs = WtProjectOrders.find(:all, :order=>"dsp_pos", :conditions=>"uid=-1")
      prjs.each do |po|
        dsp_prj = po.dsp_prj
        dsp_pos = po.dsp_pos
        next unless @prj_cost.key?(dsp_prj) # å¤ã®ç¡ãEEã­ã¸ã§ã¯ããEãã¹
        next unless @prj_cost[dsp_prj].key?(-1) # å¤ã®ç¡ãEEã­ã¸ã§ã¯ããEãã¹
        next if @prj_cost[dsp_prj][-1] == 0 # å¤ã®ç¡ãEEã­ã¸ã§ã¯ããEã¹ãE
        prj =Project.find(dsp_prj)
        
        #-------------------------------------- ãã±ãEã®ã«ã¼ãE
        tickets = WtTicketRelay.find(:all, :order=>"position")
        tickets.each do |tic|
          issue_id = tic.issue_id
          next unless @issue_cost.key?(issue_id) # å¤ã®ç¡ãEã±ãEã¯ãã¹
          next unless @issue_cost[issue_id].key?(-1) # å¤ã®ç¡ãEã±ãEã¯ãã¹
          next if @issue_cost[issue_id][-1] == 0 # å¤ã®ç¡ãEã±ãEã¯ãã¹
          next unless @issue_cost[issue_id].key?(user.id) # å¤ã®ç¡ãEã±ãEã¯ãã¹
          next if @issue_cost[issue_id][user.id] == 0 # å¤ã®ç¡ãEã±ãEã¯ãã¹

          issue = Issue.find_by_id(issue_id)
          next if issue.nil? # ãã±ãEãåé¤ããã¦ãEããã¹
          next if issue.project_id != dsp_prj # ããEãã­ã¸ã§ã¯ãã«è¡¨ç¤ºãããã±ãEã§ãªãE ´åãEãã¹

          parent_issue = Issue.find_by_id(@issue_parent[issue_id])
          next if parent_issue.nil? # ãã±ãEãåé¤ããã¦ãEããã¹

          csv_data << "\"#{user}\",\"#{parent_issue.project}\",\"#{parent_issue.subject}\",\"#{prj}\",\"#{issue.to_s}\",#{@issue_cost[issue_id][user.id]}\n"
        end
      end
      if @issue_cost.has_key?(-1) && @issue_cost[-1].has_key?(user.id) then
        csv_data << "\"#{user}\",\"private\",\"private\",\"private\",\"private\",#{@issue_cost[-1][user.id]}\n"
      end
    end
    send_data Redmine::CodesetUtil.from_utf8(csv_data, l(:general_csv_encoding)), :type=>"text/csv", :filename=>"monthly_report_raw.csv"
  end

  def edit_relay
    @message = ""
    find_project
    authorize
    prepare_values
    add_ticket_relay
    change_member_position
    change_ticket_position
    change_project_position
    member_add_del_check
    calc_total
    @link_params.merge!(:action=>"edit_relay")
  end

  def relay_total
    @message = ""
    find_project
    authorize
    prepare_values
    add_ticket_relay
    change_member_position
    change_ticket_position
    change_project_position
    member_add_del_check
    calc_total
    @link_params.merge!(:action=>"relay_total")
  end

  def relay_total_data
    find_project
    authorize
    prepare_values
    add_ticket_relay
    change_member_position
    change_ticket_position
    change_project_position
    member_add_del_check
    calc_total
    
    csv_data = "\"user\",\"project\",\"ticket\",\"spend time\"\n"
    #-------------------------------------- ã¡ã³ããEã®ã«ã¼ãE
    @members.each do |mem_info|
      user = mem_info[1]

      #-------------------------------------- ãã­ã¸ã§ã¯ããEã«ã¼ãE
      prjs = WtProjectOrders.find(:all, :order=>"dsp_pos", :conditions=>"uid=-1")
      prjs.each do |po|
        dsp_prj = po.dsp_prj
        dsp_pos = po.dsp_pos
        next unless @r_prj_cost.key?(dsp_prj) # å¤ã®ç¡ãEEã­ã¸ã§ã¯ããEãã¹
        next unless @r_prj_cost[dsp_prj].key?(-1) # å¤ã®ç¡ãEEã­ã¸ã§ã¯ããEãã¹
        next if @r_prj_cost[dsp_prj][-1] == 0 # å¤ã®ç¡ãEEã­ã¸ã§ã¯ããEã¹ãE
        prj =Project.find(dsp_prj)
        
        #-------------------------------------- ãã±ãEã®ã«ã¼ãE
        tickets = WtTicketRelay.find(:all, :order=>"position")
        tickets.each do |tic|
          issue_id = tic.issue_id
          next unless @r_issue_cost.key?(issue_id) # å¤ã®ç¡ãEã±ãEã¯ãã¹
          next unless @r_issue_cost[issue_id].key?(-1) # å¤ã®ç¡ãEã±ãEã¯ãã¹
          next if @r_issue_cost[issue_id][-1] == 0 # å¤ã®ç¡ãEã±ãEã¯ãã¹
          next unless @r_issue_cost[issue_id].key?(user.id) # å¤ã®ç¡ãEã±ãEã¯ãã¹
          next if @r_issue_cost[issue_id][user.id] == 0 # å¤ã®ç¡ãEã±ãEã¯ãã¹

          issue = Issue.find_by_id(issue_id)
          next if issue.nil? # ãã±ãEãåé¤ããã¦ãEããã¹
          next if issue.project_id != dsp_prj # ããEãã­ã¸ã§ã¯ãã«è¡¨ç¤ºãããã±ãEã§ãªãE ´åãEãã¹

          csv_data << "\"#{user}\",\"#{prj}\",\"#{issue.subject}\",#{@r_issue_cost[issue_id][user.id]}\n"
        end
      end
      if @r_issue_cost.has_key?(-1) && @r_issue_cost[-1].has_key?(user.id) then
        csv_data << "\"#{user}\",\"private\",\"private\",#{@r_issue_cost[-1][user.id]}\n"
      end
    end
    send_data Redmine::CodesetUtil.from_utf8(csv_data, l(:general_csv_encoding)), :type=>"text/csv", :filename=>"monthly_report.csv"
  end

  def popup_select_ticket # ãã±ãEé¸æã¦ã£ã³ãã¦ã®åE®¹ãè¿ãã¢ã¯ã·ã§ã³
    render(:layout=>false)
  end

  def ajax_select_ticket # ãã±ãEé¸æã¦ã£ã³ãã¦ã«Ajaxã§æ¿å¥(Update)ãããåEå®¹ãè¿ãã¢ã¯ã·ã§ã³
    render(:layout=>false)
  end

  def popup_select_tickets # è¤E°ãã±ãEé¸æã¦ã£ã³ãã¦ã®åE®¹ãè¿ãã¢ã¯ã·ã§ã³
    render(:layout=>false)
  end

  def ajax_select_tickets # è¤E°ãã±ãEé¸æã¦ã£ã³ãã¦ã«Ajaxã§æ¿å¥(Update)ãããåEå®¹ãè¿ãã¢ã¯ã·ã§ã³
    render(:layout=>false)
  end

  def ajax_insert_daily # æ¥æ¯å·¥æ°ã«æ¿å¥ããAjaxã¢ã¯ã·ã§ã³
    prepare_values

    uid = params[:user]
    @add_issue_id = params[:add_issue]
    @add_count = params[:count]
    if @this_uid==@crnt_uid then
      add_issue = Issue.find_by_id(@add_issue_id)
      @add_issue_children_cnt = Issue.count(
          :conditions => ["parent_id = " + add_issue.id.to_s]
      )
      if add_issue && add_issue.visible? then
        prj = add_issue.project
        if User.current.allowed_to?(:log_time, prj) then
          if add_issue.closed? then
            @issueHtml = "<del>"+add_issue.to_s+"</del>"
          else
            @issueHtml = add_issue.to_s
          end

          @activities = []
          prj.activities.each do |act|
            @activities.push([act.name, act.id])
          end

          @custom_fields = TimeEntryCustomField.find(:all)
          @custom_fields.each do |cf|
            def cf.custom_field
              return self
            end
            def cf.value
              return self.default_value
            end
            def cf.true?
              return self.default_value
            end
          end

          @add_issue = add_issue

          unless UserIssueMonth.exists?(["uid=:u and issue=:i",{:u=>uid, :i=>@add_issue_id}]) then
            # æ¢å­ãEã¬ã³ã¼ããå­å¨ãã¦ãEªããã°è¿½å 
            UserIssueMonth.create(:uid=>uid, :issue=>@add_issue_id,
              :odr=>UserIssueMonth.count(:conditions=>["uid=:u",{:u=>uid}])+1)
          end
        end
      end
    end

    render(:layout=>false)
  end

  def ajax_memo_edit # æ¥æ¯ãEã¡ã¢å¥åãã©ã¼ã ãåEåããAjaxã¢ã¯ã·ã§ã³
    render(:layout=>false)
  end

  def ajax_relay_table
    @message = ""
    find_project
    authorize
    prepare_values
    add_ticket_relay
    @link_params.merge!(:action=>"edit_relay")
    render(:layout=>false)
  end

  def popup_update_done_ratio # é²æï¼E´æ°ãããã¢ãEE
    issue_id = params[:issue_id]
    @issue = Issue.find_by_id(issue_id)
    if @issue.nil? || @issue.closed? || !@issue.visible? then
      @issueHtml = "<del>"+@issue.to_s+"</del>"
    else
      @issueHtml = @issue.to_s
    end
    render(:layout=>false)
  end

  def ajax_update_done_ratio
    issue_id = params[:issue_id]
    done_ratio = params[:done_ratio]
    @issue = Issue.find_by_id(issue_id)
    if User.current.allowed_to?(:edit_issues, @issue.project) then
      @issue.init_journal(User.current)
      @issue.done_ratio = done_ratio
      @issue.save
    end
    render(:layout=>false)
  end

private
  def find_project
    # Redmine Pluginã¨ãã¦å¿E¦ãããã®ã§@projectãè¨­å®E
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def prepare_values
    # ************************************* å¤ã®æºå
    @crnt_uid = User.current.id
    @this_uid = (params.key?(:user) && User.current.allowed_to?(:view_work_time_other_member, @project)) ? params[:user].to_i : @crnt_uid
    @this_user = User.find_by_id(@this_uid)

    @today = Date.today
    @this_year = params.key?(:year) ? params[:year].to_i : @today.year
    @this_month = params.key?(:month) ? params[:month].to_i : @today.month
    @this_day = params.key?(:day) ? params[:day].to_i : @today.day
    @this_date = Date.new(@this_year, @this_month, @this_day)
    @last_month = @this_date << 1
    @next_month = @this_date >> 1
    @month_str = sprintf("%04d-%02d", @this_year, @this_month)

    @restrict_project = (params.key?(:prj) && params[:prj].to_i > 0) ? params[:prj].to_i : false

    @first_date = Date.new(@this_year, @this_month, 1)
    @last_date = (@first_date >> 1) - 1

    @month_names = l(:wt_month_names).split(',')
    @wday_name = l(:wt_week_day_names).split(',')
    @wday_color = ["#faa", "#eee", "#eee", "#eee", "#eee", "#eee", "#aaf"]

#YD - added currnt logged ID
    @link_params = {:controller=>"work_time", :id=>@project,
                    :year=>@this_year, :month=>@this_month, :day=>@this_day,
                    :user=>@this_uid, :prj=>@restrict_project, :crntuser=>@crnt_uid}
    @is_registerd_backlog = false
    begin
      Redmine::Plugin.find :redmine_backlogs
      @is_registerd_backlog = true
    rescue Exception => exception
    end
  end

  def ticket_pos
    return if @this_uid != @crnt_uid

    # éè¤Eé¤ã¨é EºãEæ­£è¦å
    if order_normalization(UserIssueMonth, :issue, :order=>"odr", :conditions=>["uid=:u",{:u=>@this_uid}]) then
      @message += '<div style="background:#faa;">Warning: normalize UserIssueMonth</div>'
      return
    end

    # è¡¨ç¤ºãã±ãEé Eºå¤æ´æ±åEçE
    if params.key?("ticket_pos") && params[:ticket_pos] =~ /^(.*)_(.*)$/ then
      tid = $1.to_i
      dst = $2.to_i
      src = UserIssueMonth.find(:first, :conditions=>
            ["uid=:u and issue=:i", {:u=>@this_uid,:i=>tid}])
      if src then # ãã¸ã·ã§ã³å¤æ´ã®å ´åE
        if src.odr > dst then # ãã±ãEãåã«ãã£ã¦ãEå ´åE
          tgts = UserIssueMonth.find(:all, :conditions=>
          ["uid=:u and odr>=:o1 and odr<:o2",
          {:u=>src.uid, :o1=>dst, :o2=>src.odr}])
          tgts.each do |tgt|
            tgt.odr += 1; tgt.save# é E½ãã²ã¨ã¤ãã¤å¾ã¸
          end
          src.odr = dst; src.save
        else # ãã±ãEãå¾ã«æã£ã¦ãEå ´åE
          tgts = UserIssueMonth.find(:all, :conditions=>
          ["uid=:u and odr<=:o1 and odr>:o2",
          {:u=>src.uid, :o1=>dst, :o2=>src.odr}])
          tgts.each do |tgt|
            tgt.odr -= 1; tgt.save# é E½ãã²ã¨ã¤ãã¤å¾ã¸
          end
          src.odr = dst; src.save
        end
      else
        # æ°è¦ãEãã¸ã·ã§ã³ã®å ´åE
        tgts = UserIssueMonth.find(:all, :conditions=> ["uid=:u and odr>=:o1",
                                                  {:u=>@this_uid, :o1=>dst}])
        tgts.each do |tgt|
          tgt.odr += 1; tgt.save# é E½ãã²ã¨ã¤ãã¤å¾ã¸
        end
        UserIssueMonth.create(:uid=>@this_uid, :issue=>tid, :odr=>dst) # è¿½å 
      end
    end
  end

  def prj_pos
    return if @this_uid != @crnt_uid

    # éè¤Eé¤ã¨é EºãEæ­£è¦å
    if order_normalization(WtProjectOrders, :dsp_prj, :order=>"dsp_pos", :conditions=>["uid=:u",{:u=>@this_uid}]) then
      @message += '<div style="background:#faa;">Warning: normalize WtProjectOrders</div>'
      return
    end

    # è¡¨ç¤ºãã­ã¸ã§ã¯ãé Eºå¤æ´æ±åEçE
    if params.key?("prj_pos") && params[:prj_pos] =~ /^(.*)_(.*)$/ then
      tid = $1.to_i
      dst = $2.to_i
      src = WtProjectOrders.find(:first, :conditions=>["uid=:u and dsp_prj=:d",{:u=>@this_uid, :d=>tid}])

      if src then # ãã¸ã·ã§ã³å¤æ´ã®å ´åE
        if src.dsp_pos > dst then # ãã±ãEãåã«ãã£ã¦ãEå ´åE
          tgts = WtProjectOrders.find(:all, :conditions=>[
                 "uid=:u and dsp_pos>=:o1 and dsp_pos<:o2",
                 {:u=>@this_uid, :o1=>dst, :o2=>src.dsp_pos}])
          tgts.each do |tgt|
            tgt.dsp_pos += 1; tgt.save# é E½ãã²ã¨ã¤ãã¤å¾ã¸
          end
          src.dsp_pos = dst; src.save
        else # ãã±ãEãå¾ã«æã£ã¦ãEå ´åE
          tgts = WtProjectOrders.find(:all, :conditions=>[
                 "uid=:u and dsp_pos<=:o1 and dsp_pos>:o2",
                 {:u=>@this_uid, :o1=>dst, :o2=>src.dsp_pos}])
          tgts.each do |tgt|
            tgt.dsp_pos -= 1; tgt.save# é E½ãã²ã¨ã¤ãã¤å¾ã¸
          end
          src.dsp_pos = dst; src.save
        end
      else
        # æ°è¦ãEãã¸ã·ã§ã³ã®å ´åE
          tgts = WtProjectOrders.find(:all, :conditions=>["uid=:u and dsp_pos>=:o1",
                                       {:u=>@this_uid, :o1=>dst}])
          tgts.each do |tgt|
            tgt.dsp_pos += 1; tgt.save# é E½ãã²ã¨ã¤ãã¤å¾ã¸
          end
          WtProjectOrders.create(:uid=>@this_uid, :dsp_prj=>tid, :dsp_pos=>dst)
      end
    end
  end

  def ticket_del # ãã±ãEåé¤å¦çE
    if params.key?("ticket_del") then
      if params["ticket_del"]=="closed" then # çµäºEã±ãEå¨åé¤ã®å ´åE
          issues = Issue.find(:all,
                      :joins=>"INNER JOIN user_issue_months ON user_issue_months.issue=issues.id",
                      :conditions=>["user_issue_months.uid=:u",{:u=>@this_uid}])
          issues.each do |issue|
            if issue.closed? then
              tgt = UserIssueMonth.find(:first,
                       :conditions=>["uid=:u and issue=:i",{:u=>@this_uid,:i=>issue.id}])
              tgt.destroy
            end
          end
          return
      end

      # ãã±ãEçªå·æE®ãEåé¤ã®å ´åE
      src = UserIssueMonth.find(:first, :conditions=>
      ["uid=:u and issue=:i",
      {:u=>@this_uid,:i=>params["ticket_del"]}])
      if src && src.uid == @crnt_uid then
          tgts = UserIssueMonth.find(:all, :conditions=>
                 ["uid=:u and odr>:o",{:u=>src.uid, :o=>src.odr}])
          tgts.each do |tgt|
            tgt.odr -= 1; tgt.save# å½è©²ãã±ãEè¡¨ç¤ºããå¾ãã®å¨ãã±ãEã®é E½ãã¢ãEE
          end
          src.destroy# å½è©²ãã±ãEè¡¨ç¤ºãåé¤
      end
    end
  end

  def hour_update # *********************************** å·¥æ°æ´æ°è¦æ±ãEå¦çE
    return unless @this_uid == @crnt_uid || User.current.allowed_to?(:edit_work_time_other_member, @project)

    # æ°è¦å·¥æ°ã®ç»é²
    if params["new_time_entry"] then
      params["new_time_entry"].each do |issue_id, valss|
        issue = Issue.find_by_id(issue_id)
        next if issue.nil? || !issue.visible?
        next if !User.current.allowed_to?(:log_time, issue.project)
        valss.each do |count, vals|
          tm_vals = vals.slice! "remaining_hours", "status_id"
          next if tm_vals["hours"].blank? && vals["remaining_hours"].blank? && vals["status_id"].blank?
          if !tm_vals[:activity_id] then
            append_error_message_html(@message, 'Error: Issue'+issue_id+': No Activities!')
            next
          end
          if tm_vals["hours"].present? then
            new_entry = TimeEntry.new(:project => issue.project, :issue => issue, :user => @this_user, :spent_on => @this_date)
            new_entry.safe_attributes = tm_vals
            new_entry.save
            append_error_message_html(@message, hour_update_check_error(new_entry, issue_id))
          end
          if vals["remaining_hours"].present? || vals["status_id"].present? then
            append_error_message_html(@message, issue_update_to_remain_and_more(issue_id, vals))
          end
        end
      end
    end

    # æ¢å­å·¥æ°ã®æ´æ°
    if params["time_entry"] then
      params["time_entry"].each do |id, vals|
        tm = TimeEntry.find(id)
        issue_id = tm.issue.id
        tm_vals = vals.slice! "remaining_hours", "status_id"
        if tm_vals["hours"].blank? then
          # å·¥æ°æE®ãç©ºæE­ãEå ´åãEå·¥æ°é E®ãåé¤
          tm.destroy
        else
          tm.safe_attributes = tm_vals
          tm.save
          append_error_message_html(@message, hour_update_check_error(tm, issue_id))
        end
        if vals["remaining_hours"].present? || vals["status_id"].present? then
          append_error_message_html(@message, issue_update_to_remain_and_more(issue_id, vals))
        end
      end
    end
  end

  def issue_update_to_remain_and_more(issue_id, vals)
    issue = Issue.find_by_id(issue_id)
    return 'Error: Issue'+issue_id+': Private!' if issue.nil? || !issue.visible?
    return if vals["remaining_hours"].blank? && vals["status_id"].blank?
    journal = issue.init_journal(User.current)
    # update "0.0" is changed
    vals["remaining_hours"] = 0 if vals["remaining_hours"] == "0.0"
    if vals['status_id'] =~ /^M+(.*)$/
      vals['status_id'] = $1
    else
      vals.delete 'status_id'
    end
    issue.safe_attributes = vals
    return if !issue.changed?
    issue.save
    hour_update_check_error(issue, issue_id)
  end

  def append_error_message_html(html, msg)
    @message += '<div style="background:#faa;">' + msg + '</div><br>' if !msg.blank?
  end

  def hour_update_check_error(obj, issue_id)
    return "" if obj.errors.empty?
    str = l("field_issue")+"#"+issue_id.to_s+"<br>"
    fm = obj.errors.full_messages
    fm.each do |msg|
        str += msg+"<br>"
    end
    str.html_safe
  end

  def member_add_del_check
    # ãã­ã¸ã§ã¯ããEã¡ã³ããEãåå¾E
    mem = Member.find(:all, :conditions=>
                          ["project_id=:prj", {:prj=>@project.id}])
    mem_by_uid = {}
    mem.each do |m|
      mem_by_uid[m.user_id] = m
    end

    # ã¡ã³ããEã®é Eºãåå¾E
    odr = WtMemberOrder.find(:all,
                             :conditions=>["prj_id=:p", {:p=>@project.id}],
                             :order=>"position")

    # å½æã®ã¦ã¼ã¶æ¯ãEå·¥æ°å¥åæ°ãåå¾E
    entry_count = TimeEntry.find(:all, 
      :select=>"user_id, count(hours)as cnt",
      :conditions=>["spent_on>=:first_date and spent_on<=:last_date",
                    {:first_date=>@first_date, :last_date=>@last_date}],
      :group=>"user_id")
    cnt_by_uid = {}
    entry_count.each do |ec|
      cnt_by_uid[ec.user_id] = ec.cnt
    end

    @members = []
    pos = 1
    # é Eºæå ±ã«ãã£ã¦ã¡ã³ããEã«ç¡ãEã®ããã§ãE¯
    odr.each do |o|
      if mem_by_uid.has_key?(o.user_id) then
        user=mem_by_uid[o.user_id].user
        # é E½ãEç¢ºèªã¨ä¿®æ­£
        if o.position != pos then
          o.position=pos
          o.save
        end
        # è¡¨ç¤ºã¡ã³ããEã«è¿½å 
        if user.active? || cnt_by_uid.has_key?(user.id) then
          @members.push([pos, user])
        end
        pos += 1
        # é Eºæå ±ã«å­å¨ããã¡ã³ããEãåã£ã¦ãE
        mem_by_uid.delete(o.user_id)
      else
        # ã¡ã³ããEã«ç¡ãE Eºæå ±ã¯åé¤ãã
        o.destroy
      end
    end

    # æ®ã£ãã¡ã³ããEãé Eºæå ±ã«å ãã
    mem_by_uid.each do |k,v|
      user = v.user
      next if user.nil?
      n = WtMemberOrder.new(:user_id=>user.id,
                              :position=>pos,
                              :prj_id=>@project.id)
      n.save
      if user.active? || cnt_by_uid.has_key?(user.id) then
        @members.push([pos, user])
      end
      pos += 1
    end
    
  end

  def update_daily_memo # æ¥ãã¨ã¡ã¢ã®æ´æ°
    text = params["memo"] || return # ã¡ã¢æ´æ°ã®postããããEE
    year = params["year"] || return
    month = params["month"] || return
    day = params["day"] || return
    user_id = params["user"] || return

    # ã¦ã¼ã¶ã¨æ¥ä»ã§æ¢å­ãEã¡ã¢ãæ¤ç´¢
    date = Date.new(year.to_i,month.to_i,day.to_i)
    find = WtDailyMemo.find(:all, :conditions=>["day=:d and user_id=:u",{:d=>date,:u=>user_id}])
    while find.size > 1 do # ããè¤E°è¦ã¤ãã£ãã
      (find.shift).destroy # æ¶ãã¦ãã
    end

    if find.size != 0 then
      # æ¢å­ãEã¡ã¢ããããE
      record = find.shift
      record.description = text
      record.updated_on = Time.now
      record.save # æ´æ°
    else
      # æ¢å­ãEã¡ã¢ããªããã°æ°è¦ä½æE
      now = Time.now
      WtDailyMemo.create(:user_id=>user_id,
                         :day=>date,
                         :created_on=>now,
                         :updated_on=>now,
                         :description=>text)
    end
  end

  ################################ ä¼æ¥è¨­å®E
  def set_holiday
debugger
# change the set and del for current user (logged-in)
#    user_id = params["user"] || return
    user_id = params["crntuser"] || return

    if set_date = params['set_holiday'] then
      WtHolidays.create(:holiday=>set_date, :created_on=>Time.now, :created_by=>user_id)
    end
    if del_date = params['del_holiday'] then
	#YD Start - Delete leaves or holidays for perticular user.
      holidays = WtHolidays.find(:all, :conditions=>["holiday=:h and created_by=:u and deleted_on is null",{:h=>del_date,:u=>user_id}])
      holidays.each do |h|
        h.deleted_on = Time.now
        h.deleted_by = user_id
        h.save
      end
    end
  end

  def add_ticket_relay
    ################################### ãã±ãEä»ãæ¿ãé¢ä¿åEçE
    @parentHtml = ""
    if params.key?("ticket_relay") && params[:ticket_relay]=~/^(.*)_(.*)$/ then
      child_id = $1.to_i
      parent_id = $2.to_i
      @issue_id = child_id
      if User.current.allowed_to?(:edit_work_time_total, @project) then

        anc_id = parent_id
        while anc_id != 0 do
          break if anc_id == child_id
          relay = WtTicketRelay.find(:first, :conditions=>["issue_id=:i",{:i=>anc_id}])
          break if !relay
          anc_id = relay.parent
        end

        if anc_id != child_id then
          relay = WtTicketRelay.find(:first, :conditions=>["issue_id=:i",{:i=>child_id}])
          if relay then
            relay.parent = parent_id
            relay.save
          end
        else
          @message += '<div style="background:#faa;">'+l(:wt_loop_relay)+'</div>'
          return
        end
      else
        @message += '<div style="background:#faa;">'+l(:wt_no_permission)+'</div>'
        return
      end

      @Issue = Issue.find_by_id(@issue_id)
      @redmine_parent_id = @Issue.parent_id
      @parent_id = parent_id
      if parent_id != 0 && !((parent = Issue.find_by_id(parent_id)).nil?) then
        @parentHtml = parent.closed? ? "<del>"+parent.to_s+"</del>" : parent.to_s
      end
    end
  end

  def change_member_position
    ################################### ã¡ã³ããEé Eºå¤æ´å¦çE
    if params.key?("member_pos") && params[:member_pos]=~/^(.*)_(.*)$/ then
      if User.current.allowed_to?(:edit_work_time_total, @project) then
        uid = $1.to_i
        dst = $2.to_i
        mem = WtMemberOrder.find(:first, :conditions=>["prj_id=:p and user_id=:u",{:p=>@project.id, :u=>uid}])
        if mem then
          if mem.position > dst then # ã¡ã³ããEãåã«æã£ã¦ãEå ´åE
            tgts = WtMemberOrder.find(:all, :conditions=>
            ["prj_id=:p and position>=:p1 and position<:p2",{:p=>@project.id, :p1=>dst, :p2=>mem.position}])
            tgts.each do |mv|
              mv.position+=1; mv.save # é E½ãä¸ã¤ãã¤å¾ã¸
            end
            mem.position=dst; mem.save
          end
          if mem.position < dst then # ã¡ã³ããEãå¾ã«æã£ã¦ãEå ´åE
            tgts = WtMemberOrder.find(:all, :conditions=>
            ["prj_id=:p and position<=:p1 and position>:p2",{:p=>@project.id, :p1=>dst, :p2=>mem.position}])
            tgts.each do |mv|
              mv.position-=1; mv.save # é E½ãä¸ã¤ãã¤åã¸
            end
            mem.position=dst; mem.save
          end
        end
      else
        @message = '<div style="background:#faa;">'+l(:wt_no_permission)+'</div>'
        return
      end
    end
  end

  def change_ticket_position
    # éè¤Eé¤ã¨é EºãEæ­£è¦å
    if order_normalization(WtTicketRelay, :issue_id, :order=>"position") then
      @message += '<div style="background:#faa;">Warning: normalize WtTicketRelay</div>'
      return
    end

    ################################### ãã±ãEè¡¨ç¤ºé Eºå¤æ´å¦çE
    if params.key?("ticket_pos") && params[:ticket_pos]=~/^(.*)_(.*)$/ then
      if User.current.allowed_to?(:edit_work_time_total, @project) then
        issue_id = $1.to_i
        dst = $2.to_i
        relay = WtTicketRelay.find(:first, :conditions=>["issue_id=:i",{:i=>issue_id}])
        if relay then
          if relay.position > dst then # åã«æã£ã¦ãEå ´åE
            tgts = WtTicketRelay.find(:all, :conditions=>
            ["position>=:p1 and position<:p2",{:p1=>dst, :p2=>relay.position}])
            tgts.each do |mv|
              mv.position+=1; mv.save # é E½ãä¸ã¤ãã¤å¾ã¸
            end
            relay.position=dst; relay.save
          end
          if relay.position < dst then # å¾ã«æã£ã¦ãEå ´åE
            tgts = WtTicketRelay.find(:all, :conditions=>
            ["position<=:p1 and position>:p2",{:p1=>dst, :p2=>relay.position}])
            tgts.each do |mv|
              mv.position-=1; mv.save # é E½ãä¸ã¤ãã¤åã¸
            end
            relay.position=dst; relay.save
          end
        end
      else
        @message += '<div style="background:#faa;">'+l(:wt_no_permission)+'</div>'
        return
      end
    end
  end


  def change_project_position
    # éè¤Eé¤ã¨é EºãEæ­£è¦å
    if order_normalization(WtProjectOrders, :dsp_prj, :order=>"dsp_pos", :conditions=>"uid=-1") then
      @message += '<div style="background:#faa;">Warning: normalize WtProjectOrders</div>'
      return
    end

    ################################### ãã­ã¸ã§ã¯ãè¡¨ç¤ºé Eºå¤æ´å¦çE
    return if !params.key?("prj_pos") # ä½ç½®å¤æ´ãã©ã¡ã¼ã¿ãç¡ããã°ãã¹
    return if !(params[:prj_pos]=~/^(.*)_(.*)$/) # ãã©ã¡ã¼ã¿ã®å½¢å¼ãæ­£ãããªããã°ãã¹
    dsp_prj = $1.to_i
    dst = $2.to_i

    if !User.current.allowed_to?(:edit_work_time_total, @project) then
       # æ¨©éãç¡ããã°ãã¹
      @message += '<div style="background:#faa;">'+l(:wt_no_permission)+'</div>'
      return
    end

    po = WtProjectOrders.find(:first, :conditions=>["uid=-1 and dsp_prj=:d",{:d=>dsp_prj}])
    return if po == nil # å¯¾è±¡ã®è¡¨ç¤ºãã­ã¸ã§ã¯ããç¡ããã°ãã¹

    if po.dsp_pos > dst then # åã«æã£ã¦ãEå ´åE
      tgts = WtProjectOrders.find(:all, :conditions=> ["uid=-1 and dsp_pos>=:o1 and dsp_pos<:o2",{:o1=>dst, :o2=>po.dsp_pos}])
      tgts.each do |mv|
        mv.dsp_pos+=1; mv.save # é E½ãä¸ã¤ãã¤å¾ã¸
      end
      po.dsp_pos=dst; po.save
    end

    if po.dsp_pos < dst then # å¾ã«æã£ã¦ãEå ´åE
      tgts = WtProjectOrders.find(:all, :conditions=> ["uid=-1 and dsp_pos<=:o1 and dsp_pos>:o2",{:o1=>dst, :o2=>po.dsp_pos}])
      tgts.each do |mv|
        mv.dsp_pos-=1; mv.save # é E½ãä¸ã¤ãã¤åã¸
      end
      po.dsp_pos=dst; po.save
    end
  end

  def calc_total
    ################################################  åè¨éè¨è¨ç®ã«ã¼ãE########
    @total_cost = 0
    @member_cost = Hash.new
    WtMemberOrder.find(:all, :conditions=>["prj_id=:p",{:p=>@project.id}]).each do |i|
      @member_cost[i.user_id] = 0
    end
    @issue_parent = Hash.new # clear cash
    @issue_cost = Hash.new
    @r_issue_cost = Hash.new
    relay = Hash.new
    WtTicketRelay.find(:all).each do |i|
      relay[i.issue_id] = i.parent
    end
    @prj_cost = Hash.new
    @r_prj_cost = Hash.new

    #å½æã®æéè¨é²ãæ½åº
    TimeEntry.find(:all, :conditions =>
    ["spent_on>=:t1 and spent_on<=:t2 and hours>0",
    {:t1 => @first_date, :t2 => @last_date}]).each do |time_entry|
      iid = time_entry.issue_id
      uid = time_entry.user_id
      cost = time_entry.hours

      # æ¬ãã­ã¸ã§ã¯ããEã¦ã¼ã¶ã®å·¥æ°ã§ãªããã°ãã¹
      next unless @member_cost.key?(uid)

      issue = Issue.find_by_id(iid)
      next if issue.nil? # ãã±ãEãåé¤ããã¦ãEããã¹
      pid = issue.project_id
      # ãã­ã¸ã§ã¯ãéå®ãEå¯¾è±¡ã§ãªããã°ãã¹
      next if @restrict_project && pid != @restrict_project

      @total_cost += cost
      @member_cost[uid] += cost

      parent_iid = get_parent_issue(relay, iid)

      if !Issue.find_by_id(iid) || !Issue.find_by_id(iid).visible?
        iid = -1 # private
        pid = -1 # private
      end
      @issue_cost[iid] ||= Hash.new
      @issue_cost[iid][-1] ||= 0
      @issue_cost[iid][-1] += cost
      @issue_cost[iid][uid] ||= 0
      @issue_cost[iid][uid] += cost

      @prj_cost[pid] ||= Hash.new
      @prj_cost[pid][-1] ||= 0
      @prj_cost[pid][-1] += cost
      @prj_cost[pid][uid] ||= 0
      @prj_cost[pid][uid] += cost

      parent_issue = Issue.find_by_id(parent_iid)
      if parent_issue && parent_issue.visible?
        parent_pid = parent_issue.project_id
      else
        parent_iid = -1
        parent_pid = -1
      end

      @r_issue_cost[parent_iid] ||= Hash.new
      @r_issue_cost[parent_iid][-1] ||= 0
      @r_issue_cost[parent_iid][-1] += cost
      @r_issue_cost[parent_iid][uid] ||= 0
      @r_issue_cost[parent_iid][uid] += cost

      @r_prj_cost[parent_pid] ||= Hash.new
      @r_prj_cost[parent_pid][-1] ||= 0
      @r_prj_cost[parent_pid][-1] += cost
      @r_prj_cost[parent_pid][uid] ||= 0
      @r_prj_cost[parent_pid][uid] += cost
    end
  end

  def get_parent_issue(relay, iid)
    @issue_parent ||= Hash.new
    return @issue_parent[iid] if @issue_parent.has_key?(iid)
    issue = Issue.find_by_id(iid)
    return 0 if issue.nil? # issueãåé¤ããã¦ãEãããã¾ã§

    if relay.has_key?(iid)
      parent_id = relay[iid]
      if parent_id != 0 && parent_id != iid
        parent_id = get_parent_issue(relay, parent_id)
      end
      parent_id = iid if parent_id == 0
    else
      # é¢é£ãç»é²ããã¦ãEªãE ´åãEç»é²ãã
      WtTicketRelay.create(:issue_id=>iid, :position=>relay.size, :parent=>0)
      parent_id = iid
    end

    # iid ã«å¯¾ããåãã¦ã®å¦çE
    pid = issue.project_id
    unless @prj_cost.has_key?(pid)
      check = WtProjectOrders.find(:all, :conditions=>["uid=-1 and dsp_prj=:p",{:p=>pid}])
      if check.size == 0
        WtProjectOrders.create(:uid=>-1, :dsp_prj=>pid, :dsp_pos=>@prj_cost.size)
      end
    end

    @issue_parent[iid] = parent_id # return
  end

  def make_pack
    # æéå·¥æ°è¡¨ã®ãEEã¿ãä½æE
    @month_pack = {:ref_prjs=>{}, :odr_prjs=>[],
                   :total=>0, :total_by_day=>{},
                   :other=>0, :other_by_day=>{},
                   :count_prjs=>0, :count_issues=>0}
    @month_pack[:total_by_day].default = 0

    # æ¥æ¯å·¥æ°ã®ãEEã¿ãä½æE
    @day_pack = {:ref_prjs=>{}, :odr_prjs=>[],
                 :total=>0, :total_by_day=>{},
                 :other=>0, :other_by_day=>{},
                 :count_prjs=>0, :count_issues=>0}
    @day_pack[:total_by_day].default = 0

    # ãã­ã¸ã§ã¯ãé EEè¡¨ç¤ºãEEã¿ãä½æE
    dsp_prjs = Project.find(:all, :joins=>"INNER JOIN wt_project_orders ON wt_project_orders.dsp_prj=projects.id",
                          :select=>"projects.*, wt_project_orders.dsp_pos",
                          :conditions=>["wt_project_orders.uid=:u",{:u=>@this_uid}],
                          :order=>"wt_project_orders.dsp_pos")
    dsp_prjs.each do |prj|
      next if @restrict_project && @restrict_project!=prj.id
      make_pack_prj(@month_pack, prj, prj.dsp_pos)
      make_pack_prj(@day_pack, prj, prj.dsp_pos)
    end
    @prj_odr_max = dsp_prjs.length

    # ãã±ãEé EEè¡¨ç¤ºãEEã¿ãä½æE
    dsp_issues = Issue.find(:all, :joins=>"INNER JOIN user_issue_months ON user_issue_months.issue=issues.id",
                            :select=>"issues.*, user_issue_months.odr",
                            :conditions=>["user_issue_months.uid=:u",{:u=>@this_uid}],
                            :order=>"user_issue_months.odr")
    dsp_issues.each do |issue|
      next if @restrict_project && @restrict_project!=issue.project.id
      month_prj_pack = make_pack_prj(@month_pack, issue.project)
      make_pack_issue(month_prj_pack, issue, issue.odr)
      day_prj_pack = make_pack_prj(@day_pack, issue.project)
      make_pack_issue(day_prj_pack, issue, issue.odr)
    end
    @issue_odr_max = dsp_issues.length

    # æåEã®å·¥æ°ãéè¨E
    hours = TimeEntry.find(:all, :conditions =>
          ["user_id=:uid and spent_on>=:day1 and spent_on<=:day2",
          {:uid => @this_uid, :day1 => @first_date, :day2 => @last_date}],
        :include => [:issue])
    hours.each do |hour|
      next if @restrict_project && @restrict_project!=hour.project.id
      work_time = hour.hours
      if hour.issue && hour.issue.visible? then
        # è¡¨ç¤ºé E®ã«å·¥æ°ã®ãã­ã¸ã§ã¯ããããããã§ãE¯âãªããã°é E®è¿½å 
        prj_pack = make_pack_prj(@month_pack, hour.project)

        # è¡¨ç¤ºé E®ã«å·¥æ°ã®ãã±ãEãããããã§ãE¯âãªããã°é E®è¿½å 
        issue_pack = make_pack_issue(prj_pack, hour.issue)

        issue_pack[:count_hours] += 1

        # åè¨æéãEè¨ç®E
        @month_pack[:total] += work_time
        prj_pack[:total] += work_time
        issue_pack[:total] += work_time

        # æ¥æ¯ãEåè¨æéãEè¨ç®E
        date = hour.spent_on
        @month_pack[:total_by_day][date] += work_time
        prj_pack[:total_by_day][date] += work_time
        issue_pack[:total_by_day][date] += work_time

        if date==@this_date then # è¡¨ç¤ºæ¥ã®å·¥æ°ã§ããã°é E®è¿½å 
          # è¡¨ç¤ºé E®ã«å·¥æ°ã®ãã­ã¸ã§ã¯ããããããã§ãE¯âãªããã°é E®è¿½å 
          day_prj_pack = make_pack_prj(@day_pack, hour.project)

          # è¡¨ç¤ºé E®ã«å·¥æ°ã®ãã±ãEãããããã§ãE¯âãªããã°é E®è¿½å 
          day_issue_pack = make_pack_issue(day_prj_pack, hour.issue, NO_ORDER)

          day_issue_pack[:each_entries][hour.id] = hour # å·¥æ°ã¨ã³ããªãè¿½å 
          day_issue_pack[:total] += work_time
          day_prj_pack[:total] += work_time
          @day_pack[:total] += work_time
        end
      else
        # åè¨æéãEè¨ç®E
        @month_pack[:total] += work_time
        @month_pack[:other] += work_time

        # æ¥æ¯ãEåè¨æéãEè¨ç®E
        date = hour.spent_on
        @month_pack[:total_by_day][date] ||= 0
        @month_pack[:total_by_day][date] += work_time
        @month_pack[:other_by_day][date] ||= 0
        @month_pack[:other_by_day][date] += work_time

        if date==@this_date then # è¡¨ç¤ºæ¥ã®å·¥æ°ã§ããã°é E®è¿½å 
          @day_pack[:total] += work_time
          @day_pack[:other] += work_time
        end
      end
    end

    # ããEæ¥ã®ãã±ãEä½æEãæ´ãåºãE
    next_date = @this_date+1
    t1 = Time.local(@this_date.year, @this_date.month, @this_date.day)
    t2 = Time.local(next_date.year, next_date.month, next_date.day)
    issues = Issue.find(:all,
              :conditions => ["1 = 1
                         and ((issues.author_id = :u
                           and issues.created_on >= :t1
                           and issues.created_on < :t2)
                           or (exists (select 1 from journals
                                       where journals.journalized_id = issues.id
                                         and journals.journalized_type = 'Issue'
                                         and journals.user_id = :u
                                         and journals.created_on >= :t1
                                         and journals.created_on < :t2)))",
                          {:u => @this_uid, :t1 => t1, :t2 => t2, :closed => false}])
    issues.each do |issue|
      next if @restrict_project && @restrict_project!=issue.project.id
      next if !@this_user.allowed_to?(:log_time, issue.project)
      next if !issue.visible?
      prj_pack = make_pack_prj(@day_pack, issue.project)
      issue_pack = make_pack_issue(prj_pack, issue)
      if issue_pack[:css_classes] == 'wt_iss_overdue'
        issue_pack[:css_classes] = 'wt_iss_overdue_worked'
      else
        issue_pack[:css_classes] = 'wt_iss_worked'
      end
    end
    issues = Issue.find(:all,
                        :joins => "INNER JOIN issue_statuses ist on ist.id = issues.status_id",
                        :conditions => ["1 = 1
                         and (issues.assigned_to_id = :u
                           and issues.start_date < :t2
                           and ist.is_closed = :closed
                           )",
                                        {:u => @this_uid, :t2 => t2, :closed => false}])
    issues.each do |issue|
      next if @restrict_project && @restrict_project!=issue.project.id
      next if !@this_user.allowed_to?(:log_time, issue.project)
      next if !issue.visible?
      prj_pack = make_pack_prj(@day_pack, issue.project)
      issue_pack = make_pack_issue(prj_pack, issue)
      if issue_pack[:css_classes] == 'wt_iss_default'
        issue_pack[:css_classes] = 'wt_iss_assigned'
      elsif issue_pack[:css_classes] == 'wt_iss_worked'
        issue_pack[:css_classes] = 'wt_iss_assigned_worked'
      elsif issue_pack[:css_classes] == 'wt_iss_overdue'
        issue_pack[:css_classes] = 'wt_iss_assigned_overdue'
      elsif issue_pack[:css_classes] == 'wt_iss_overdue_worked'
        issue_pack[:css_classes] = 'wt_iss_assigned_overdue_worked'
      end
    end

    # æéå·¥æ°è¡¨ããå·¥æ°ãç¡ãã£ãé E®ã®åé¤ã¨é E®æ°ã®ã«ã¦ã³ãE
    @month_pack[:count_issues] = 0
    @month_pack[:odr_prjs].each do |prj_pack|
      prj_pack[:odr_issues].each do |issue_pack|
        if issue_pack[:count_hours]==0 then
          prj_pack[:count_issues] -= 1
        end
      end

      if prj_pack[:count_issues]==0 then
        @month_pack[:count_prjs] -= 1
      else
        @month_pack[:count_issues] += prj_pack[:count_issues]
      end
    end
  end

  def make_pack_prj(pack, new_prj, odr=NO_ORDER)
      # è¡¨ç¤ºé E®ã«å½è©²ãã­ã¸ã§ã¯ããããããã§ãE¯âãªããã°é E®è¿½å 
      unless pack[:ref_prjs].has_key?(new_prj.id) then
        prj_pack = {:odr=>odr, :prj=>new_prj,
                    :total=>0, :total_by_day=>{},
                    :ref_issues=>{}, :odr_issues=>[], :count_issues=>0}
        pack[:ref_prjs][new_prj.id] = prj_pack
        pack[:odr_prjs].push prj_pack
        pack[:count_prjs] += 1
        prj_pack[:total_by_day].default = 0
      end
      pack[:ref_prjs][new_prj.id]
  end

  def make_pack_issue(prj_pack, new_issue, odr=NO_ORDER)
      id = new_issue.nil? ? -1 : new_issue.id
      # è¡¨ç¤ºé E®ã«å½è©²ãã±ãEãããããã§ãE¯âãªããã°é E®è¿½å 
      unless prj_pack[:ref_issues].has_key?(id) then
        issue_pack = {:odr=>odr, :issue=>new_issue,
                      :total=>0, :total_by_day=>{},
                      :count_hours=>0, :each_entries=>{},
                      :cnt_childrens=>0}
        issue_pack[:total_by_day].default = 0
        if !new_issue.due_date.nil? && new_issue.due_date < @this_date.to_datetime
          issue_pack[:css_classes] = 'wt_iss_overdue'
        else
          issue_pack[:css_classes] = 'wt_iss_default'
        end
        prj_pack[:ref_issues][id] = issue_pack
        prj_pack[:odr_issues].push issue_pack
        prj_pack[:count_issues] += 1
        cnt_childrens = Issue.count(
            :conditions => ["parent_id = " + new_issue.id.to_s]
        )
        issue_pack[:cnt_childrens] = cnt_childrens
      end
      prj_pack[:ref_issues][id]
  end

  def sum_or_nil(v1, v2)
    if v2.blank?
      v1
    else
      if v1.blank?
        v2
      else
        v1 + v2
      end
    end
  end

  # éè¤Eé¤ã¨é EºãEæ­£è¦å
  def order_normalization(table, key_column, find_params)
    raise "need table" unless table
    order = find_params[:order]
    raise "need :order" unless order
    update = false

    tgts = table.find(:all, find_params)
    keys = []
    tgts.each do |tgt|
      if keys.include?(tgt[key_column]) then
        tgt.destroy
        update = true
      else
        keys.push(tgt[key_column])
        if tgt[order] != keys.length then
          tgt[order] = keys.length
          tgt.save
          update = true
        end
      end
    end
    update
  end

end
