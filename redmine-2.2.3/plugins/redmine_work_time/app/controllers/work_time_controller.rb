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
    #-------------------------------------- 繝｡繝ｳ繝舌・縺ｮ繝ｫ繝ｼ繝・
    @members.each do |mem_info|
      user = mem_info[1]

      #-------------------------------------- 繝励Ο繧ｸ繧ｧ繧ｯ繝医・繝ｫ繝ｼ繝・
      prjs = WtProjectOrders.find(:all, :order=>"dsp_pos", :conditions=>"uid=-1")
      prjs.each do |po|
        dsp_prj = po.dsp_prj
        dsp_pos = po.dsp_pos
        next unless @prj_cost.key?(dsp_prj) # 蛟､縺ｮ辟｡縺・・繝ｭ繧ｸ繧ｧ繧ｯ繝医・繝代せ
        next unless @prj_cost[dsp_prj].key?(-1) # 蛟､縺ｮ辟｡縺・・繝ｭ繧ｸ繧ｧ繧ｯ繝医・繝代せ
        next if @prj_cost[dsp_prj][-1] == 0 # 蛟､縺ｮ辟｡縺・・繝ｭ繧ｸ繧ｧ繧ｯ繝医・繧ｹ繝・
        prj =Project.find(dsp_prj)
        
        #-------------------------------------- 繝√こ繝・ヨ縺ｮ繝ｫ繝ｼ繝・
        tickets = WtTicketRelay.find(:all, :order=>"position")
        tickets.each do |tic|
          issue_id = tic.issue_id
          next unless @issue_cost.key?(issue_id) # 蛟､縺ｮ辟｡縺・メ繧ｱ繝・ヨ縺ｯ繝代せ
          next unless @issue_cost[issue_id].key?(-1) # 蛟､縺ｮ辟｡縺・メ繧ｱ繝・ヨ縺ｯ繝代せ
          next if @issue_cost[issue_id][-1] == 0 # 蛟､縺ｮ辟｡縺・メ繧ｱ繝・ヨ縺ｯ繝代せ
          next unless @issue_cost[issue_id].key?(user.id) # 蛟､縺ｮ辟｡縺・メ繧ｱ繝・ヨ縺ｯ繝代せ
          next if @issue_cost[issue_id][user.id] == 0 # 蛟､縺ｮ辟｡縺・メ繧ｱ繝・ヨ縺ｯ繝代せ

          issue = Issue.find_by_id(issue_id)
          next if issue.nil? # 繝√こ繝・ヨ縺悟炎髯､縺輔ｌ縺ｦ縺・◆繧峨ヱ繧ｹ
          next if issue.project_id != dsp_prj # 縺薙・繝励Ο繧ｸ繧ｧ繧ｯ繝医↓陦ｨ遉ｺ縺吶ｋ繝√こ繝・ヨ縺ｧ縺ｪ縺・ｴ蜷医・繝代せ

          parent_issue = Issue.find_by_id(@issue_parent[issue_id])
          next if parent_issue.nil? # 繝√こ繝・ヨ縺悟炎髯､縺輔ｌ縺ｦ縺・◆繧峨ヱ繧ｹ

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
    #-------------------------------------- 繝｡繝ｳ繝舌・縺ｮ繝ｫ繝ｼ繝・
    @members.each do |mem_info|
      user = mem_info[1]

      #-------------------------------------- 繝励Ο繧ｸ繧ｧ繧ｯ繝医・繝ｫ繝ｼ繝・
      prjs = WtProjectOrders.find(:all, :order=>"dsp_pos", :conditions=>"uid=-1")
      prjs.each do |po|
        dsp_prj = po.dsp_prj
        dsp_pos = po.dsp_pos
        next unless @r_prj_cost.key?(dsp_prj) # 蛟､縺ｮ辟｡縺・・繝ｭ繧ｸ繧ｧ繧ｯ繝医・繝代せ
        next unless @r_prj_cost[dsp_prj].key?(-1) # 蛟､縺ｮ辟｡縺・・繝ｭ繧ｸ繧ｧ繧ｯ繝医・繝代せ
        next if @r_prj_cost[dsp_prj][-1] == 0 # 蛟､縺ｮ辟｡縺・・繝ｭ繧ｸ繧ｧ繧ｯ繝医・繧ｹ繝・
        prj =Project.find(dsp_prj)
        
        #-------------------------------------- 繝√こ繝・ヨ縺ｮ繝ｫ繝ｼ繝・
        tickets = WtTicketRelay.find(:all, :order=>"position")
        tickets.each do |tic|
          issue_id = tic.issue_id
          next unless @r_issue_cost.key?(issue_id) # 蛟､縺ｮ辟｡縺・メ繧ｱ繝・ヨ縺ｯ繝代せ
          next unless @r_issue_cost[issue_id].key?(-1) # 蛟､縺ｮ辟｡縺・メ繧ｱ繝・ヨ縺ｯ繝代せ
          next if @r_issue_cost[issue_id][-1] == 0 # 蛟､縺ｮ辟｡縺・メ繧ｱ繝・ヨ縺ｯ繝代せ
          next unless @r_issue_cost[issue_id].key?(user.id) # 蛟､縺ｮ辟｡縺・メ繧ｱ繝・ヨ縺ｯ繝代せ
          next if @r_issue_cost[issue_id][user.id] == 0 # 蛟､縺ｮ辟｡縺・メ繧ｱ繝・ヨ縺ｯ繝代せ

          issue = Issue.find_by_id(issue_id)
          next if issue.nil? # 繝√こ繝・ヨ縺悟炎髯､縺輔ｌ縺ｦ縺・◆繧峨ヱ繧ｹ
          next if issue.project_id != dsp_prj # 縺薙・繝励Ο繧ｸ繧ｧ繧ｯ繝医↓陦ｨ遉ｺ縺吶ｋ繝√こ繝・ヨ縺ｧ縺ｪ縺・ｴ蜷医・繝代せ

          csv_data << "\"#{user}\",\"#{prj}\",\"#{issue.subject}\",#{@r_issue_cost[issue_id][user.id]}\n"
        end
      end
      if @r_issue_cost.has_key?(-1) && @r_issue_cost[-1].has_key?(user.id) then
        csv_data << "\"#{user}\",\"private\",\"private\",#{@r_issue_cost[-1][user.id]}\n"
      end
    end
    send_data Redmine::CodesetUtil.from_utf8(csv_data, l(:general_csv_encoding)), :type=>"text/csv", :filename=>"monthly_report.csv"
  end

  def popup_select_ticket # 繝√こ繝・ヨ驕ｸ謚槭え繧｣繝ｳ繝峨え縺ｮ蜀・ｮｹ繧定ｿ斐☆繧｢繧ｯ繧ｷ繝ｧ繝ｳ
    render(:layout=>false)
  end

  def ajax_select_ticket # 繝√こ繝・ヨ驕ｸ謚槭え繧｣繝ｳ繝峨え縺ｫAjax縺ｧ謖ｿ蜈･(Update)縺輔ｌ繧句・螳ｹ繧定ｿ斐☆繧｢繧ｯ繧ｷ繝ｧ繝ｳ
    render(:layout=>false)
  end

  def popup_select_tickets # 隍・焚繝√こ繝・ヨ驕ｸ謚槭え繧｣繝ｳ繝峨え縺ｮ蜀・ｮｹ繧定ｿ斐☆繧｢繧ｯ繧ｷ繝ｧ繝ｳ
    render(:layout=>false)
  end

  def ajax_select_tickets # 隍・焚繝√こ繝・ヨ驕ｸ謚槭え繧｣繝ｳ繝峨え縺ｫAjax縺ｧ謖ｿ蜈･(Update)縺輔ｌ繧句・螳ｹ繧定ｿ斐☆繧｢繧ｯ繧ｷ繝ｧ繝ｳ
    render(:layout=>false)
  end

  def ajax_insert_daily # 譌･豈主ｷ･謨ｰ縺ｫ謖ｿ蜈･縺吶ｋAjax繧｢繧ｯ繧ｷ繝ｧ繝ｳ
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
            # 譌｢蟄倥・繝ｬ繧ｳ繝ｼ繝峨′蟄伜惠縺励※縺・↑縺代ｌ縺ｰ霑ｽ蜉
            UserIssueMonth.create(:uid=>uid, :issue=>@add_issue_id,
              :odr=>UserIssueMonth.count(:conditions=>["uid=:u",{:u=>uid}])+1)
          end
        end
      end
    end

    render(:layout=>false)
  end

  def ajax_memo_edit # 譌･豈弱・繝｡繝｢蜈･蜉帙ヵ繧ｩ繝ｼ繝繧貞・蜉帙☆繧帰jax繧｢繧ｯ繧ｷ繝ｧ繝ｳ
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

  def popup_update_done_ratio # 騾ｲ謐暦ｼ・峩譁ｰ繝昴ャ繝励い繝・・
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
    # Redmine Plugin縺ｨ縺励※蠢・ｦ√ｉ縺励＞縺ｮ縺ｧ@project繧定ｨｭ螳・
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def prepare_values
    # ************************************* 蛟､縺ｮ貅門ｙ
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

    # 驥崎､・炎髯､縺ｨ鬆・ｺ上・豁｣隕丞喧
    if order_normalization(UserIssueMonth, :issue, :order=>"odr", :conditions=>["uid=:u",{:u=>@this_uid}]) then
      @message += '<div style="background:#faa;">Warning: normalize UserIssueMonth</div>'
      return
    end

    # 陦ｨ遉ｺ繝√こ繝・ヨ鬆・ｺ丞､画峩豎ょ・逅・
    if params.key?("ticket_pos") && params[:ticket_pos] =~ /^(.*)_(.*)$/ then
      tid = $1.to_i
      dst = $2.to_i
      src = UserIssueMonth.find(:first, :conditions=>
            ["uid=:u and issue=:i", {:u=>@this_uid,:i=>tid}])
      if src then # 繝昴ず繧ｷ繝ｧ繝ｳ螟画峩縺ｮ蝣ｴ蜷・
        if src.odr > dst then # 繝√こ繝・ヨ繧貞燕縺ｫ繧ゅ▲縺ｦ縺・￥蝣ｴ蜷・
          tgts = UserIssueMonth.find(:all, :conditions=>
          ["uid=:u and odr>=:o1 and odr<:o2",
          {:u=>src.uid, :o1=>dst, :o2=>src.odr}])
          tgts.each do |tgt|
            tgt.odr += 1; tgt.save# 鬆・ｽ阪ｒ縺ｲ縺ｨ縺､縺壹▽蠕後∈
          end
          src.odr = dst; src.save
        else # 繝√こ繝・ヨ繧貞ｾ後↓謖√▲縺ｦ縺・￥蝣ｴ蜷・
          tgts = UserIssueMonth.find(:all, :conditions=>
          ["uid=:u and odr<=:o1 and odr>:o2",
          {:u=>src.uid, :o1=>dst, :o2=>src.odr}])
          tgts.each do |tgt|
            tgt.odr -= 1; tgt.save# 鬆・ｽ阪ｒ縺ｲ縺ｨ縺､縺壹▽蠕後∈
          end
          src.odr = dst; src.save
        end
      else
        # 譁ｰ隕上・繝昴ず繧ｷ繝ｧ繝ｳ縺ｮ蝣ｴ蜷・
        tgts = UserIssueMonth.find(:all, :conditions=> ["uid=:u and odr>=:o1",
                                                  {:u=>@this_uid, :o1=>dst}])
        tgts.each do |tgt|
          tgt.odr += 1; tgt.save# 鬆・ｽ阪ｒ縺ｲ縺ｨ縺､縺壹▽蠕後∈
        end
        UserIssueMonth.create(:uid=>@this_uid, :issue=>tid, :odr=>dst) # 霑ｽ蜉
      end
    end
  end

  def prj_pos
    return if @this_uid != @crnt_uid

    # 驥崎､・炎髯､縺ｨ鬆・ｺ上・豁｣隕丞喧
    if order_normalization(WtProjectOrders, :dsp_prj, :order=>"dsp_pos", :conditions=>["uid=:u",{:u=>@this_uid}]) then
      @message += '<div style="background:#faa;">Warning: normalize WtProjectOrders</div>'
      return
    end

    # 陦ｨ遉ｺ繝励Ο繧ｸ繧ｧ繧ｯ繝磯・ｺ丞､画峩豎ょ・逅・
    if params.key?("prj_pos") && params[:prj_pos] =~ /^(.*)_(.*)$/ then
      tid = $1.to_i
      dst = $2.to_i
      src = WtProjectOrders.find(:first, :conditions=>["uid=:u and dsp_prj=:d",{:u=>@this_uid, :d=>tid}])

      if src then # 繝昴ず繧ｷ繝ｧ繝ｳ螟画峩縺ｮ蝣ｴ蜷・
        if src.dsp_pos > dst then # 繝√こ繝・ヨ繧貞燕縺ｫ繧ゅ▲縺ｦ縺・￥蝣ｴ蜷・
          tgts = WtProjectOrders.find(:all, :conditions=>[
                 "uid=:u and dsp_pos>=:o1 and dsp_pos<:o2",
                 {:u=>@this_uid, :o1=>dst, :o2=>src.dsp_pos}])
          tgts.each do |tgt|
            tgt.dsp_pos += 1; tgt.save# 鬆・ｽ阪ｒ縺ｲ縺ｨ縺､縺壹▽蠕後∈
          end
          src.dsp_pos = dst; src.save
        else # 繝√こ繝・ヨ繧貞ｾ後↓謖√▲縺ｦ縺・￥蝣ｴ蜷・
          tgts = WtProjectOrders.find(:all, :conditions=>[
                 "uid=:u and dsp_pos<=:o1 and dsp_pos>:o2",
                 {:u=>@this_uid, :o1=>dst, :o2=>src.dsp_pos}])
          tgts.each do |tgt|
            tgt.dsp_pos -= 1; tgt.save# 鬆・ｽ阪ｒ縺ｲ縺ｨ縺､縺壹▽蠕後∈
          end
          src.dsp_pos = dst; src.save
        end
      else
        # 譁ｰ隕上・繝昴ず繧ｷ繝ｧ繝ｳ縺ｮ蝣ｴ蜷・
          tgts = WtProjectOrders.find(:all, :conditions=>["uid=:u and dsp_pos>=:o1",
                                       {:u=>@this_uid, :o1=>dst}])
          tgts.each do |tgt|
            tgt.dsp_pos += 1; tgt.save# 鬆・ｽ阪ｒ縺ｲ縺ｨ縺､縺壹▽蠕後∈
          end
          WtProjectOrders.create(:uid=>@this_uid, :dsp_prj=>tid, :dsp_pos=>dst)
      end
    end
  end

  def ticket_del # 繝√こ繝・ヨ蜑企勁蜃ｦ逅・
    if params.key?("ticket_del") then
      if params["ticket_del"]=="closed" then # 邨ゆｺ・メ繧ｱ繝・ヨ蜈ｨ蜑企勁縺ｮ蝣ｴ蜷・
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

      # 繝√こ繝・ヨ逡ｪ蜿ｷ謖・ｮ壹・蜑企勁縺ｮ蝣ｴ蜷・
      src = UserIssueMonth.find(:first, :conditions=>
      ["uid=:u and issue=:i",
      {:u=>@this_uid,:i=>params["ticket_del"]}])
      if src && src.uid == @crnt_uid then
          tgts = UserIssueMonth.find(:all, :conditions=>
                 ["uid=:u and odr>:o",{:u=>src.uid, :o=>src.odr}])
          tgts.each do |tgt|
            tgt.odr -= 1; tgt.save# 蠖楢ｩｲ繝√こ繝・ヨ陦ｨ遉ｺ繧医ｊ蠕後ｍ縺ｮ蜈ｨ繝√こ繝・ヨ縺ｮ鬆・ｽ阪ｒ繧｢繝・・
          end
          src.destroy# 蠖楢ｩｲ繝√こ繝・ヨ陦ｨ遉ｺ繧貞炎髯､
      end
    end
  end

  def hour_update # *********************************** 蟾･謨ｰ譖ｴ譁ｰ隕∵ｱゅ・蜃ｦ逅・
    return unless @this_uid == @crnt_uid || User.current.allowed_to?(:edit_work_time_other_member, @project)

    # 譁ｰ隕丞ｷ･謨ｰ縺ｮ逋ｻ骭ｲ
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

    # 譌｢蟄伜ｷ･謨ｰ縺ｮ譖ｴ譁ｰ
    if params["time_entry"] then
      params["time_entry"].each do |id, vals|
        tm = TimeEntry.find(id)
        issue_id = tm.issue.id
        tm_vals = vals.slice! "remaining_hours", "status_id"
        if tm_vals["hours"].blank? then
          # 蟾･謨ｰ謖・ｮ壹′遨ｺ譁・ｭ励・蝣ｴ蜷医・蟾･謨ｰ鬆・岼繧貞炎髯､
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
    # 繝励Ο繧ｸ繧ｧ繧ｯ繝医・繝｡繝ｳ繝舌・繧貞叙蠕・
    mem = Member.find(:all, :conditions=>
                          ["project_id=:prj", {:prj=>@project.id}])
    mem_by_uid = {}
    mem.each do |m|
      mem_by_uid[m.user_id] = m
    end

    # 繝｡繝ｳ繝舌・縺ｮ鬆・ｺ上ｒ蜿門ｾ・
    odr = WtMemberOrder.find(:all,
                             :conditions=>["prj_id=:p", {:p=>@project.id}],
                             :order=>"position")

    # 蠖捺怦縺ｮ繝ｦ繝ｼ繧ｶ豈弱・蟾･謨ｰ蜈･蜉帶焚繧貞叙蠕・
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
    # 鬆・ｺ乗ュ蝣ｱ縺ｫ縺ゅ▲縺ｦ繝｡繝ｳ繝舌・縺ｫ辟｡縺・ｂ縺ｮ繧偵メ繧ｧ繝・け
    odr.each do |o|
      if mem_by_uid.has_key?(o.user_id) then
        user=mem_by_uid[o.user_id].user
        # 鬆・ｽ阪・遒ｺ隱阪→菫ｮ豁｣
        if o.position != pos then
          o.position=pos
          o.save
        end
        # 陦ｨ遉ｺ繝｡繝ｳ繝舌・縺ｫ霑ｽ蜉
        if user.active? || cnt_by_uid.has_key?(user.id) then
          @members.push([pos, user])
        end
        pos += 1
        # 鬆・ｺ乗ュ蝣ｱ縺ｫ蟄伜惠縺励◆繝｡繝ｳ繝舌・繧貞炎縺｣縺ｦ縺・￥
        mem_by_uid.delete(o.user_id)
      else
        # 繝｡繝ｳ繝舌・縺ｫ辟｡縺・・ｺ乗ュ蝣ｱ縺ｯ蜑企勁縺吶ｋ
        o.destroy
      end
    end

    # 谿九▲縺溘Γ繝ｳ繝舌・繧帝・ｺ乗ュ蝣ｱ縺ｫ蜉縺医ｋ
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

  def update_daily_memo # 譌･縺斐→繝｡繝｢縺ｮ譖ｴ譁ｰ
    text = params["memo"] || return # 繝｡繝｢譖ｴ譁ｰ縺ｮpost縺後≠繧九°・・
    year = params["year"] || return
    month = params["month"] || return
    day = params["day"] || return
    user_id = params["user"] || return

    # 繝ｦ繝ｼ繧ｶ縺ｨ譌･莉倥〒譌｢蟄倥・繝｡繝｢繧呈､懃ｴ｢
    date = Date.new(year.to_i,month.to_i,day.to_i)
    find = WtDailyMemo.find(:all, :conditions=>["day=:d and user_id=:u",{:d=>date,:u=>user_id}])
    while find.size > 1 do # 繧ゅ＠隍・焚隕九▽縺九▲縺溘ｉ
      (find.shift).destroy # 豸医＠縺ｦ縺翫￥
    end

    if find.size != 0 then
      # 譌｢蟄倥・繝｡繝｢縺後≠繧後・
      record = find.shift
      record.description = text
      record.updated_on = Time.now
      record.save # 譖ｴ譁ｰ
    else
      # 譌｢蟄倥・繝｡繝｢縺後↑縺代ｌ縺ｰ譁ｰ隕丈ｽ懈・
      now = Time.now
      WtDailyMemo.create(:user_id=>user_id,
                         :day=>date,
                         :created_on=>now,
                         :updated_on=>now,
                         :description=>text)
    end
  end

  ################################ 莨第律險ｭ螳・
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
    ################################### 繝√こ繝・ヨ莉倥￠譖ｿ縺磯未菫ょ・逅・
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
    ################################### 繝｡繝ｳ繝舌・鬆・ｺ丞､画峩蜃ｦ逅・
    if params.key?("member_pos") && params[:member_pos]=~/^(.*)_(.*)$/ then
      if User.current.allowed_to?(:edit_work_time_total, @project) then
        uid = $1.to_i
        dst = $2.to_i
        mem = WtMemberOrder.find(:first, :conditions=>["prj_id=:p and user_id=:u",{:p=>@project.id, :u=>uid}])
        if mem then
          if mem.position > dst then # 繝｡繝ｳ繝舌・繧貞燕縺ｫ謖√▲縺ｦ縺・￥蝣ｴ蜷・
            tgts = WtMemberOrder.find(:all, :conditions=>
            ["prj_id=:p and position>=:p1 and position<:p2",{:p=>@project.id, :p1=>dst, :p2=>mem.position}])
            tgts.each do |mv|
              mv.position+=1; mv.save # 鬆・ｽ阪ｒ荳縺､縺壹▽蠕後∈
            end
            mem.position=dst; mem.save
          end
          if mem.position < dst then # 繝｡繝ｳ繝舌・繧貞ｾ後↓謖√▲縺ｦ縺・￥蝣ｴ蜷・
            tgts = WtMemberOrder.find(:all, :conditions=>
            ["prj_id=:p and position<=:p1 and position>:p2",{:p=>@project.id, :p1=>dst, :p2=>mem.position}])
            tgts.each do |mv|
              mv.position-=1; mv.save # 鬆・ｽ阪ｒ荳縺､縺壹▽蜑阪∈
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
    # 驥崎､・炎髯､縺ｨ鬆・ｺ上・豁｣隕丞喧
    if order_normalization(WtTicketRelay, :issue_id, :order=>"position") then
      @message += '<div style="background:#faa;">Warning: normalize WtTicketRelay</div>'
      return
    end

    ################################### 繝√こ繝・ヨ陦ｨ遉ｺ鬆・ｺ丞､画峩蜃ｦ逅・
    if params.key?("ticket_pos") && params[:ticket_pos]=~/^(.*)_(.*)$/ then
      if User.current.allowed_to?(:edit_work_time_total, @project) then
        issue_id = $1.to_i
        dst = $2.to_i
        relay = WtTicketRelay.find(:first, :conditions=>["issue_id=:i",{:i=>issue_id}])
        if relay then
          if relay.position > dst then # 蜑阪↓謖√▲縺ｦ縺・￥蝣ｴ蜷・
            tgts = WtTicketRelay.find(:all, :conditions=>
            ["position>=:p1 and position<:p2",{:p1=>dst, :p2=>relay.position}])
            tgts.each do |mv|
              mv.position+=1; mv.save # 鬆・ｽ阪ｒ荳縺､縺壹▽蠕後∈
            end
            relay.position=dst; relay.save
          end
          if relay.position < dst then # 蠕後↓謖√▲縺ｦ縺・￥蝣ｴ蜷・
            tgts = WtTicketRelay.find(:all, :conditions=>
            ["position<=:p1 and position>:p2",{:p1=>dst, :p2=>relay.position}])
            tgts.each do |mv|
              mv.position-=1; mv.save # 鬆・ｽ阪ｒ荳縺､縺壹▽蜑阪∈
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
    # 驥崎､・炎髯､縺ｨ鬆・ｺ上・豁｣隕丞喧
    if order_normalization(WtProjectOrders, :dsp_prj, :order=>"dsp_pos", :conditions=>"uid=-1") then
      @message += '<div style="background:#faa;">Warning: normalize WtProjectOrders</div>'
      return
    end

    ################################### 繝励Ο繧ｸ繧ｧ繧ｯ繝郁｡ｨ遉ｺ鬆・ｺ丞､画峩蜃ｦ逅・
    return if !params.key?("prj_pos") # 菴咲ｽｮ螟画峩繝代Λ繝｡繝ｼ繧ｿ縺檎┌縺代ｌ縺ｰ繝代せ
    return if !(params[:prj_pos]=~/^(.*)_(.*)$/) # 繝代Λ繝｡繝ｼ繧ｿ縺ｮ蠖｢蠑上′豁｣縺励￥縺ｪ縺代ｌ縺ｰ繝代せ
    dsp_prj = $1.to_i
    dst = $2.to_i

    if !User.current.allowed_to?(:edit_work_time_total, @project) then
       # 讓ｩ髯舌′辟｡縺代ｌ縺ｰ繝代せ
      @message += '<div style="background:#faa;">'+l(:wt_no_permission)+'</div>'
      return
    end

    po = WtProjectOrders.find(:first, :conditions=>["uid=-1 and dsp_prj=:d",{:d=>dsp_prj}])
    return if po == nil # 蟇ｾ雎｡縺ｮ陦ｨ遉ｺ繝励Ο繧ｸ繧ｧ繧ｯ繝医′辟｡縺代ｌ縺ｰ繝代せ

    if po.dsp_pos > dst then # 蜑阪↓謖√▲縺ｦ縺・￥蝣ｴ蜷・
      tgts = WtProjectOrders.find(:all, :conditions=> ["uid=-1 and dsp_pos>=:o1 and dsp_pos<:o2",{:o1=>dst, :o2=>po.dsp_pos}])
      tgts.each do |mv|
        mv.dsp_pos+=1; mv.save # 鬆・ｽ阪ｒ荳縺､縺壹▽蠕後∈
      end
      po.dsp_pos=dst; po.save
    end

    if po.dsp_pos < dst then # 蠕後↓謖√▲縺ｦ縺・￥蝣ｴ蜷・
      tgts = WtProjectOrders.find(:all, :conditions=> ["uid=-1 and dsp_pos<=:o1 and dsp_pos>:o2",{:o1=>dst, :o2=>po.dsp_pos}])
      tgts.each do |mv|
        mv.dsp_pos-=1; mv.save # 鬆・ｽ阪ｒ荳縺､縺壹▽蜑阪∈
      end
      po.dsp_pos=dst; po.save
    end
  end

  def calc_total
    ################################################  蜷郁ｨ磯寔險郁ｨ育ｮ励Ν繝ｼ繝・########
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

    #蠖捺怦縺ｮ譎る俣險倬鹸繧呈歓蜃ｺ
    TimeEntry.find(:all, :conditions =>
    ["spent_on>=:t1 and spent_on<=:t2 and hours>0",
    {:t1 => @first_date, :t2 => @last_date}]).each do |time_entry|
      iid = time_entry.issue_id
      uid = time_entry.user_id
      cost = time_entry.hours

      # 譛ｬ繝励Ο繧ｸ繧ｧ繧ｯ繝医・繝ｦ繝ｼ繧ｶ縺ｮ蟾･謨ｰ縺ｧ縺ｪ縺代ｌ縺ｰ繝代せ
      next unless @member_cost.key?(uid)

      issue = Issue.find_by_id(iid)
      next if issue.nil? # 繝√こ繝・ヨ縺悟炎髯､縺輔ｌ縺ｦ縺・◆繧峨ヱ繧ｹ
      pid = issue.project_id
      # 繝励Ο繧ｸ繧ｧ繧ｯ繝磯剞螳壹・蟇ｾ雎｡縺ｧ縺ｪ縺代ｌ縺ｰ繝代せ
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
    return 0 if issue.nil? # issue縺悟炎髯､縺輔ｌ縺ｦ縺・◆繧峨◎縺薙∪縺ｧ

    if relay.has_key?(iid)
      parent_id = relay[iid]
      if parent_id != 0 && parent_id != iid
        parent_id = get_parent_issue(relay, parent_id)
      end
      parent_id = iid if parent_id == 0
    else
      # 髢｢騾｣縺檎匳骭ｲ縺輔ｌ縺ｦ縺・↑縺・ｴ蜷医・逋ｻ骭ｲ縺吶ｋ
      WtTicketRelay.create(:issue_id=>iid, :position=>relay.size, :parent=>0)
      parent_id = iid
    end

    # iid 縺ｫ蟇ｾ縺吶ｋ蛻昴ａ縺ｦ縺ｮ蜃ｦ逅・
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
    # 譛磯俣蟾･謨ｰ陦ｨ縺ｮ繝・・繧ｿ繧剃ｽ懈・
    @month_pack = {:ref_prjs=>{}, :odr_prjs=>[],
                   :total=>0, :total_by_day=>{},
                   :other=>0, :other_by_day=>{},
                   :count_prjs=>0, :count_issues=>0}
    @month_pack[:total_by_day].default = 0

    # 譌･豈主ｷ･謨ｰ縺ｮ繝・・繧ｿ繧剃ｽ懈・
    @day_pack = {:ref_prjs=>{}, :odr_prjs=>[],
                 :total=>0, :total_by_day=>{},
                 :other=>0, :other_by_day=>{},
                 :count_prjs=>0, :count_issues=>0}
    @day_pack[:total_by_day].default = 0

    # 繝励Ο繧ｸ繧ｧ繧ｯ繝磯・・陦ｨ遉ｺ繝・・繧ｿ繧剃ｽ懈・
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

    # 繝√こ繝・ヨ鬆・・陦ｨ遉ｺ繝・・繧ｿ繧剃ｽ懈・
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

    # 譛亥・縺ｮ蟾･謨ｰ繧帝寔險・
    hours = TimeEntry.find(:all, :conditions =>
          ["user_id=:uid and spent_on>=:day1 and spent_on<=:day2",
          {:uid => @this_uid, :day1 => @first_date, :day2 => @last_date}],
        :include => [:issue])
    hours.each do |hour|
      next if @restrict_project && @restrict_project!=hour.project.id
      work_time = hour.hours
      if hour.issue && hour.issue.visible? then
        # 陦ｨ遉ｺ鬆・岼縺ｫ蟾･謨ｰ縺ｮ繝励Ο繧ｸ繧ｧ繧ｯ繝医′縺ゅｋ縺九メ繧ｧ繝・け竊偵↑縺代ｌ縺ｰ鬆・岼霑ｽ蜉
        prj_pack = make_pack_prj(@month_pack, hour.project)

        # 陦ｨ遉ｺ鬆・岼縺ｫ蟾･謨ｰ縺ｮ繝√こ繝・ヨ縺後≠繧九°繝√ぉ繝・け竊偵↑縺代ｌ縺ｰ鬆・岼霑ｽ蜉
        issue_pack = make_pack_issue(prj_pack, hour.issue)

        issue_pack[:count_hours] += 1

        # 蜷郁ｨ域凾髢薙・險育ｮ・
        @month_pack[:total] += work_time
        prj_pack[:total] += work_time
        issue_pack[:total] += work_time

        # 譌･豈弱・蜷郁ｨ域凾髢薙・險育ｮ・
        date = hour.spent_on
        @month_pack[:total_by_day][date] += work_time
        prj_pack[:total_by_day][date] += work_time
        issue_pack[:total_by_day][date] += work_time

        if date==@this_date then # 陦ｨ遉ｺ譌･縺ｮ蟾･謨ｰ縺ｧ縺ゅｌ縺ｰ鬆・岼霑ｽ蜉
          # 陦ｨ遉ｺ鬆・岼縺ｫ蟾･謨ｰ縺ｮ繝励Ο繧ｸ繧ｧ繧ｯ繝医′縺ゅｋ縺九メ繧ｧ繝・け竊偵↑縺代ｌ縺ｰ鬆・岼霑ｽ蜉
          day_prj_pack = make_pack_prj(@day_pack, hour.project)

          # 陦ｨ遉ｺ鬆・岼縺ｫ蟾･謨ｰ縺ｮ繝√こ繝・ヨ縺後≠繧九°繝√ぉ繝・け竊偵↑縺代ｌ縺ｰ鬆・岼霑ｽ蜉
          day_issue_pack = make_pack_issue(day_prj_pack, hour.issue, NO_ORDER)

          day_issue_pack[:each_entries][hour.id] = hour # 蟾･謨ｰ繧ｨ繝ｳ繝医Μ繧定ｿｽ蜉
          day_issue_pack[:total] += work_time
          day_prj_pack[:total] += work_time
          @day_pack[:total] += work_time
        end
      else
        # 蜷郁ｨ域凾髢薙・險育ｮ・
        @month_pack[:total] += work_time
        @month_pack[:other] += work_time

        # 譌･豈弱・蜷郁ｨ域凾髢薙・險育ｮ・
        date = hour.spent_on
        @month_pack[:total_by_day][date] ||= 0
        @month_pack[:total_by_day][date] += work_time
        @month_pack[:other_by_day][date] ||= 0
        @month_pack[:other_by_day][date] += work_time

        if date==@this_date then # 陦ｨ遉ｺ譌･縺ｮ蟾･謨ｰ縺ｧ縺ゅｌ縺ｰ鬆・岼霑ｽ蜉
          @day_pack[:total] += work_time
          @day_pack[:other] += work_time
        end
      end
    end

    # 縺薙・譌･縺ｮ繝√こ繝・ヨ菴懈・繧呈ｴ励＞蜃ｺ縺・
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

    # 譛磯俣蟾･謨ｰ陦ｨ縺九ｉ蟾･謨ｰ縺檎┌縺九▲縺滄・岼縺ｮ蜑企勁縺ｨ鬆・岼謨ｰ縺ｮ繧ｫ繧ｦ繝ｳ繝・
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
      # 陦ｨ遉ｺ鬆・岼縺ｫ蠖楢ｩｲ繝励Ο繧ｸ繧ｧ繧ｯ繝医′縺ゅｋ縺九メ繧ｧ繝・け竊偵↑縺代ｌ縺ｰ鬆・岼霑ｽ蜉
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
      # 陦ｨ遉ｺ鬆・岼縺ｫ蠖楢ｩｲ繝√こ繝・ヨ縺後≠繧九°繝√ぉ繝・け竊偵↑縺代ｌ縺ｰ鬆・岼霑ｽ蜉
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

  # 驥崎､・炎髯､縺ｨ鬆・ｺ上・豁｣隕丞喧
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
