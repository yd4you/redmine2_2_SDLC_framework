#!/usr/local/bin/ruby

require "rubygems"
require "mysql"
require 'net/smtp'
require 'date'

begin
    con = Mysql.new 'localhost', 'root', 'xxx', 'redmine_production'
    outputstr = String.new("")
    sqlstr = String.new("")
    startDt = Date.today+1
    endDt = Date.today + 16
    emailid = String.new("")
    tempemailid = String.new("")


                sqlstr = sqlstr.concat(" select        ")
                sqlstr = sqlstr.concat(" id.issue_id,id.due_date, id.estimatedRemainingHrs,id.`Actual_Remaining_Hrs`,IFNULL(id.UserName, 'Team Leader') UserName,id.projectName,id.tracker ")
                sqlstr = sqlstr.concat(" from (        ")
                sqlstr = sqlstr.concat(" select        ")
                sqlstr = sqlstr.concat("  id.ProjectName,id.UserName, id.issue_id,id.tracker, id.status,Year(id.start_date) as `yr`, id.Remaining_Hrs,id.RemainingHrs_SubTasks,        ")
                sqlstr = sqlstr.concat("  case when        ")
                sqlstr = sqlstr.concat("    (id.estimatedRemainingHrs < IF(id.RemainingHrs_SubTasks > 0, id.RemainingHrs_SubTasks, id.`Remaining_Hrs`)) and (id.`Status` <> 'Closed' and id.`Status` <> 'Completed')        ")
                sqlstr = sqlstr.concat("  then 'Getting Delayed'        ")
                sqlstr = sqlstr.concat("  when        ")
                sqlstr = sqlstr.concat("    (id.estimatedRemainingHrs = IF(id.RemainingHrs_SubTasks > 0, id.RemainingHrs_SubTasks, id.`Remaining_Hrs`)) and (id.`Status` <> 'Closed' and id.`Status` <> 'Completed')        ")
                sqlstr = sqlstr.concat("  then 'On-Track'        ")
                sqlstr = sqlstr.concat("  when        ")
                sqlstr = sqlstr.concat("     (id.estimatedRemainingHrs > IF(id.RemainingHrs_SubTasks > 0, id.RemainingHrs_SubTasks, id.`Remaining_Hrs`)) and (id.`Status` <> 'Closed' and id.`Status` <> 'Completed')        ")
                sqlstr = sqlstr.concat("  then 'Ahead'        ")
                sqlstr = sqlstr.concat("  Else   ''  end  as `Forcasting_Status`, id.BugCount,id.ReviewErrorCount,        ")
                sqlstr = sqlstr.concat("   id.estimated_hours, id.estimatedRemainingHrs, id.Total_Spent_Hrs, id.SpentHrs,  id.due_date,        ")
                sqlstr = sqlstr.concat("   IF(id.RemainingHrs_SubTasks > 0, id.RemainingHrs_SubTasks, id.`Remaining_Hrs`) as `Actual_Remaining_Hrs`,        ")
                sqlstr = sqlstr.concat(" id.mail        ")
                sqlstr = sqlstr.concat("  from        ")
                sqlstr = sqlstr.concat("  (        ")
                sqlstr = sqlstr.concat("      select i.root_id, i.id as `issue_id`,  getTotalBugCount(i.id) as `BugCount`,getTotalReviewCount(i.id) as `ReviewErrorCount`,        ")
                sqlstr = sqlstr.concat("             tk.name as `tracker`, i.project_id, p.projectName as `ProjectName`,        ")
                sqlstr = sqlstr.concat("          s.name as `Status`,  i.subject, us.login,        ")
                sqlstr = sqlstr.concat("          CONCAT(us.firstname, ' ', us.lastname) as `UserName`, us.mail, i.estimated_hours,        ")
                sqlstr = sqlstr.concat("         getTotalSpentTime(i.id) as `Total_Spent_Hrs`, timedata.SpentHrs,        ")
                sqlstr = sqlstr.concat("         cast(CAST(cv.value as char) as UNSIGNED) as `Remaining_Hrs`,        ")
                sqlstr = sqlstr.concat("         getTotalRemainingTime_SubTask(i.id) as `RemainingHrs_SubTasks` ,    CAST(cv1.value as CHAR) as `estimated_end_date` , i.start_date ,i.due_date,  cv2.value as `IssueType`,cv3.value as `Complexity`,        ")
                sqlstr = sqlstr.concat("         GREATEST(DATEDIFF(i.due_date, i.start_date)*8,0) as `totalDuration`        ")
                sqlstr = sqlstr.concat("         ,CEILING(GREATEST(NETWORKDAYS(i.due_date, curdate(),i.assigned_to_id),0))*8 as `estimatedRemainingHrs` ,isParentExist(i.id) as flg      ")
                sqlstr = sqlstr.concat("     from issues As i        ")
                sqlstr = sqlstr.concat("         ")
                sqlstr = sqlstr.concat("    LEFT OUTER JOIN `issue_statuses` AS `s` ON `i`.`status_id` = `s`.`id`        ")
                sqlstr = sqlstr.concat("             INNER JOIN (        ")
                sqlstr = sqlstr.concat("                 SELECT p.id, p.name as `projectName`        ")
                sqlstr = sqlstr.concat("                 FROM projects AS p        ")
                sqlstr = sqlstr.concat("                 where p.id not in (7,8,9,11,12,15,51,31,35,49,37)        ")
                sqlstr = sqlstr.concat("             ) `p` on i.project_id = p.id        ")
                sqlstr = sqlstr.concat("              LEFT OUTER JOIN        ")
                sqlstr = sqlstr.concat("               ( select * from  `custom_values` AS `cv` where cv.custom_field_id = 34 ) as `cv`        ")
                sqlstr = sqlstr.concat("               ON `i`.`id` = `cv`.`customized_id`        ")
                sqlstr = sqlstr.concat("             LEFT OUTER JOIN        ")
                sqlstr = sqlstr.concat("               ( select * from  `custom_values` AS `cv` where cv.custom_field_id = 54 ) AS `cv1` ON `i`.`id` = `cv1`.`customized_id`        ")
                sqlstr = sqlstr.concat("             LEFT OUTER JOIN        ")
                sqlstr = sqlstr.concat("       (  select * from  `custom_values` AS `cv`         where cv.custom_field_id = 32       ) AS `cv2` ON `i`.`id` = `cv2`.`customized_id`        ")
                sqlstr = sqlstr.concat("             LEFT OUTER JOIN        ")
                sqlstr = sqlstr.concat("       (  select * from  `custom_values` AS `cv`        where cv.custom_field_id = 49      ) AS `cv3` ON `i`.`id` = `cv3`.`customized_id`        ")
                sqlstr = sqlstr.concat("             left outer JOIN `users` as `us` ON `i`.`assigned_to_id` = `us`.`id`        ")
                sqlstr = sqlstr.concat("             LEFT OUTER JOIN `trackers` as `tk` ON `i`.`tracker_id` = `tk`.`id`        ")
                sqlstr = sqlstr.concat("         left outer join (select issue_id as  `id`, sum(hours) as `SpentHrs` from time_entries group by issue_id) as `timedata`  on i.id = timedata.id        ")
                sqlstr = sqlstr.concat(" ) as `id`        ")
                sqlstr = sqlstr.concat(" where id.flg = 0 and `id`.`status` not in ('Closed','Later','Rejected')        ")
                sqlstr = sqlstr.concat("  order by id.project_id asc, id.mail, id.issue_id asc        ")
                sqlstr = sqlstr.concat(" ) as `id`        ")
                sqlstr = sqlstr.concat(" where id.`Forcasting_Status` like '%Delayed%'        ")


 #puts sqlstr

    rs = con.query(sqlstr)
    n_rows = rs.num_rows

    puts "There are #{n_rows} rows in the result set"

        outputstr = outputstr.concat("--------------------------------------------- Header -----------------------------------------------------------------------------------------------------------------------------------\n")
        outputstr = outputstr.concat("Issue ID |\tDue Date\t|\tEstimated Remaining Hrs\t|\tActual Remaining Hrs\t|\tUser Name\t|\tProject Name\t|\tTracker\n")
        outputstr = outputstr.concat("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n")

        # For loop for each record
    n_rows.times do
#        rs.each do |row|
#               tempemailid = row[0]
#               puts "=>>> " + tempemailid + "=" +  emailid

#              if tempemailid.casecmp(emailid).zero?
#                       puts "IF == " + row[0] + "\n"
#                       #emailid = tempemailid
#                       outputstr = outputstr + rs.fetch_row.join("\t|\t")
#                       outputstr = outputstr + "\n"
#                       #puts "IF == " + rs.fetch_row.join("\t|\t")
#                       #puts "IF = " + tempemailid + "=" +  emailid
#                       next
#               else
#                       puts "ELSE == " + row[0] + "\n"
#                       puts outputstr + "\n"
#                       outputstr = ""
#                       emailid = tempemailid.downcase
#                       outputstr = outputstr + rs.fetch_row.join("\t|\t")
#                       outputstr = outputstr + "\n"
#               end

                        outputstr = outputstr + rs.fetch_row.join("\t|\t")
                        outputstr = outputstr + "\n"




    end
rescue Mysql::Error => e
    puts e.errno
    puts e.error

ensure
    con.close if con
end

if n_rows > 0
message = <<MESSAGE_END
From: RedmineAdmin-NoReply@xxxxx.com
To: xxxx@xxx
Subject: To be Delayed Task list

Dear All

Following are the tasks showing "Getting delayed" status as per remaining hrs.
Following are the tasks showing "Getting delayed" status as per remaining hrs.
So request respective member to change "Due Date" according to "Remining Hrs"
OR
Change the remaining hrs appropriately.

#{outputstr}

Regards
XXXXXXXXXXX
-------------------------------------------------
This is system genrated mail, please do not reply


MESSAGE_END


 Net::SMTP.start('localhost') do |smtp|
  smtp.send_message message, 'xxxx@xxx.xxx','xxxx@xxx.com'
                             
 end
end