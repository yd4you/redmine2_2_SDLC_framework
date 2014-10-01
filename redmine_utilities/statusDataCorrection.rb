#!/usr/local/bin/ruby

require "rubygems"
require "mysql"
require 'net/smtp'
require 'date'

begin
    con = Mysql.new 'localhost', 'root', 'passwd@vtx0', 'redmine_production'
    outputstr = String.new("")
    outputstr1 = String.new("")
    sqlstr = String.new("")
    startDt = Date.today+1
    endDt = Date.today + 16
    emailid = String.new("")
    tempemailid = String.new("")


			sqlstr = sqlstr.concat(" select        ")
			sqlstr = sqlstr.concat("   id.issue_id, id.`Total_Spent_Hrs`, id.`Remaining_Hrs`, id.done_ratio as `% Completed`,id.`Status`, IFNULL(id.UserName, 'Team Leader') UserName,id.projectName,id.tracker        ")
			sqlstr = sqlstr.concat("   from (        ")
			sqlstr = sqlstr.concat("   select        ")
			sqlstr = sqlstr.concat("   id.ProjectName,id.UserName, id.issue_id,id.tracker, Year(id.start_date) as `yr`,        ")
			sqlstr = sqlstr.concat("   id.Remaining_Hrs,id.RemainingHrs_SubTasks,        ")
			sqlstr = sqlstr.concat("   id.estimated_hours, id.estimatedRemainingHrs, id.Total_Spent_Hrs, id.SpentHrs, id.due_date,        ")
			sqlstr = sqlstr.concat("   IF(id.RemainingHrs_SubTasks > 0, id.RemainingHrs_SubTasks, id.`Remaining_Hrs`) as `Actual_Remaining_Hrs`,        ")
			sqlstr = sqlstr.concat("   id.mail, id.estimated_end_date, id.SubTaskExist, id.`Status`, id.done_ratio        ")
			sqlstr = sqlstr.concat("   from        ")
			sqlstr = sqlstr.concat("   (        ")
			sqlstr = sqlstr.concat("   select i.root_id, i.id as `issue_id`, tk.name as `tracker`, i.project_id, p.projectName as `ProjectName`,        ")
			sqlstr = sqlstr.concat("   s.name as `Status`, i.subject, us.login,        ")
			sqlstr = sqlstr.concat("   CONCAT(us.firstname, ' ', us.lastname) as `UserName`, us.mail, i.estimated_hours,        ")
			sqlstr = sqlstr.concat("   getTotalSpentTime(i.id) as `Total_Spent_Hrs`, timedata.SpentHrs,        ")
			sqlstr = sqlstr.concat("   cast(CAST(cv.value as char) as UNSIGNED) as `Remaining_Hrs`,        ")
			sqlstr = sqlstr.concat("   getTotalRemainingTime_SubTask(i.id) as `RemainingHrs_SubTasks` , CAST(cv1.value as CHAR) as `estimated_end_date` , i.start_date ,i.due_date, cv2.value as `IssueType`,cv3.value as `Complexity`,        ")
			sqlstr = sqlstr.concat("   GREATEST(DATEDIFF(i.due_date, i.start_date)*8,0) as `totalDuration`        ")
			sqlstr = sqlstr.concat("   ,CEILING(GREATEST(NETWORKDAYS(i.due_date, curdate(),i.assigned_to_id),0))*8 as `estimatedRemainingHrs`        ")
			sqlstr = sqlstr.concat("   ,isParentExist(i.id) as SubTaskExist, i.done_ratio        ")
			sqlstr = sqlstr.concat("   from issues As i          ")
			sqlstr = sqlstr.concat("   LEFT OUTER JOIN `issue_statuses` AS `s` ON `i`.`status_id` = `s`.`id`         ")
			sqlstr = sqlstr.concat("   INNER JOIN (         ")
			sqlstr = sqlstr.concat("    SELECT p.id, p.name as `projectName`         ")
			sqlstr = sqlstr.concat("    FROM projects AS p         ")
			sqlstr = sqlstr.concat("    where p.id not in (7,8,9,11,12,15,50,51,31,35,49,37,63)         ")
			sqlstr = sqlstr.concat("   ) `p` on i.project_id = p.id         ")
			sqlstr = sqlstr.concat("   LEFT OUTER JOIN         ")
			sqlstr = sqlstr.concat("    ( select * from `custom_values` AS `cv` where cv.custom_field_id = 34 ) as `cv`         ")
			sqlstr = sqlstr.concat("    ON `i`.`id` = `cv`.`customized_id`         ")
			sqlstr = sqlstr.concat("   LEFT OUTER JOIN         ")
			sqlstr = sqlstr.concat("    ( select * from `custom_values` AS `cv` where cv.custom_field_id = 54 ) AS `cv1` ON `i`.`id` = `cv1`.`customized_id`         ")
			sqlstr = sqlstr.concat("   LEFT OUTER JOIN         ")
			sqlstr = sqlstr.concat("   ( select * from `custom_values` AS `cv` where cv.custom_field_id = 32 ) AS `cv2` ON `i`.`id` = `cv2`.`customized_id`         ")
			sqlstr = sqlstr.concat("   LEFT OUTER JOIN        ")
			sqlstr = sqlstr.concat("   ( select * from `custom_values` AS `cv` where cv.custom_field_id = 49 ) AS `cv3` ON `i`.`id` = `cv3`.`customized_id`         ")
			sqlstr = sqlstr.concat("   left outer JOIN `users` as `us` ON `i`.`assigned_to_id` = `us`.`id`         ")
			sqlstr = sqlstr.concat("   LEFT OUTER JOIN `trackers` as `tk` ON `i`.`tracker_id` = `tk`.`id`         ")
			sqlstr = sqlstr.concat("   left outer join (select issue_id as `id`, sum(hours) as `SpentHrs`        ")
			sqlstr = sqlstr.concat("       from time_entries group by issue_id) as `timedata` on i.id = timedata.id        ")
			sqlstr = sqlstr.concat("   ) as `id`        ")
			sqlstr = sqlstr.concat("   where (id.`Status` in ('New') and id.`Total_Spent_Hrs` > 0) OR  ((id.`Status` in ('Completed') or id.done_ratio = 100)  and id.`Remaining_Hrs` > 0)        ")
			sqlstr = sqlstr.concat("   order by id.project_id asc, id.mail, id.issue_id asc        ")
			sqlstr = sqlstr.concat("   ) as `id`        ")


 # puts sqlstr

    rs = con.query(sqlstr)
    n_rows = rs.num_rows

    puts "There are #{n_rows} rows in the result set"
#id.issue_id, id.`Total_Spent_Hrs`, id.`Remaining_Hrs`, id.done_ratio as `% Completed`,id.`Status`, IFNULL(id.UserName, 'Team Leader') UserName,id.projectName,id.tracker
        outputstr = outputstr.concat("--------------------------------------------- Header -----------------------------------------------------------------------------------------------------------------------------------\n")
        outputstr = outputstr.concat("Issue ID\t|\tSpent Hrs\t|\tRemaining Hrs\t|\t% Completed\t|\tStatus\t\t|\tUser Name\t\t|\tProject Name\t\t|\tTracker\n")
        outputstr = outputstr.concat("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n")

        # For loop for each record
    n_rows.times do
         outputstr = outputstr + rs.fetch_row.join("\t       |\t")
         outputstr = outputstr + "\n"
    end


#==============================================================================
sqlstr = ""
sqlstr = sqlstr.concat("   select  ")
sqlstr = sqlstr.concat("   id.issue_id,id.due_date,IFNULL(id.UserName, 'Team Leader') UserName, id.tracker, `id`.`status` ,  ")
sqlstr = sqlstr.concat("   id.projectName  ")
sqlstr = sqlstr.concat("   from   ")
sqlstr = sqlstr.concat("   (  ")
sqlstr = sqlstr.concat("   select i.root_id, i.id as `issue_id`,   ")
sqlstr = sqlstr.concat("    tk.name as `tracker`, i.project_id, p.projectName as `ProjectName`,   ")
sqlstr = sqlstr.concat("    s.name as `Status`, i.subject, us.login,   ")
sqlstr = sqlstr.concat("    CONCAT(us.firstname, ' ', us.lastname) as `UserName`, us.mail,  ")
sqlstr = sqlstr.concat("    CAST(cv1.value as CHAR) as `estimated_end_date` , i.start_date ,i.due_date  ")
sqlstr = sqlstr.concat(" ,isParentExist(i.id) as flg ")
sqlstr = sqlstr.concat("   from issues As i  ")
sqlstr = sqlstr.concat("   LEFT OUTER JOIN `issue_statuses` AS `s` ON `i`.`status_id` = `s`.`id`  ")
sqlstr = sqlstr.concat("    INNER JOIN (  ")
sqlstr = sqlstr.concat("     SELECT p.id, p.name as `projectName`  ")
sqlstr = sqlstr.concat("     FROM projects AS p  ")
sqlstr = sqlstr.concat("     where p.id not in (7,8,9,11,12,15,51,31,35,49,37,50,10)  ")
sqlstr = sqlstr.concat("    ) `p` on i.project_id = p.id  ")
sqlstr = sqlstr.concat("    LEFT OUTER JOIN  ")
sqlstr = sqlstr.concat("     ( select * from `custom_values` AS `cv` where cv.custom_field_id = 34 ) as `cv`  ")
sqlstr = sqlstr.concat("     ON `i`.`id` = `cv`.`customized_id`  ")
sqlstr = sqlstr.concat("    LEFT OUTER JOIN  ")
sqlstr = sqlstr.concat("     ( select * from `custom_values` AS `cv` where cv.custom_field_id = 54 ) AS `cv1` ON `i`.`id` = `cv1`.`customized_id`  ")
sqlstr = sqlstr.concat("    left outer JOIN `users` as `us` ON `i`.`assigned_to_id` = `us`.`id`  ")
sqlstr = sqlstr.concat("    LEFT OUTER JOIN `trackers` as `tk` ON `i`.`tracker_id` = `tk`.`id`   ")
sqlstr = sqlstr.concat("   ) as `id`   ")
sqlstr = sqlstr.concat("   where `id`.`status` in ('Completed','Closed','Released','Invalid_Closed','Reviewed & Closed')  ")
sqlstr = sqlstr.concat("   and ( (curdate() < id.due_date) and (id.due_date is not null or trim(id.due_date) <> '') )  ")
sqlstr = sqlstr.concat("   order by id.project_id asc, id.mail, id.issue_id asc  ")



# puts sqlstr

    rs1 = con.query(sqlstr)
    n_rows1 = rs1.num_rows

    puts "There are #{n_rows1} rows in the result set"
        outputstr1 = outputstr1.concat("--------------------------------------------- Header -----------------------------------------------------------------------------------------------------------------------------------\n")
        outputstr1 = outputstr1.concat("Issue ID\t\t|\tDue Date\t\t|\tUser Name\t\t|\tTracker\t\t|\tStatus\t\t|\tProject Name\n")
        outputstr1 = outputstr1.concat("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n")

        # For loop for each record
    n_rows1.times do
         outputstr1 = outputstr1 + rs1.fetch_row.join("\t       |\t")
         outputstr1 = outputstr1 + "\n"
    end


#============================================================================


rescue Mysql::Error => e
    puts e.errno
    puts e.error

ensure
    con.close if con
end

if n_rows > 0 || n_rows1 > 0
message = <<MESSAGE_END
From: RedmineAdmin-NoReply@nttdata.com
To: NTTD_OSS@nttdata.com
Subject: OSS : Status Correction Check - Task list

Dear All

Following are the tasks need to be corrected with respective to following issues
1) Remove "Remaining Hrs" following tasks since task is already showing Completed / Closed
2) Change the Status of "NEW" to "In Progress or other" if you spent some hrs on it
3) If the task is completed then please check the Verifying status and if already verified then please CLOSE it.

#{outputstr}


Following are the tasks need to be corrected with respective to following issues
1) Following tasks are completed or closed however the "Due Date" showing the future date.
   When you complete any task before defined "Due Date" then change the "Due Date" with actual completion date

#{outputstr1}


Regards
NTT DATA OSS Center
-------------------------------------------------
This is system genrated mail, please do not reply


MESSAGE_END

#else

#message = <<MESSAGE_END
#From: RedmineAdmin-NoReply@nttdata.com
#To: NTTD_OSS@nttdata.com
#Subject: OSS : Status Correction Check - Task list

#Dear All

#Appreciate your efforts for updating proper status data for following criteria
#
#1) Remove "Remaining Hrs" following tasks since task is already showing Completed / Closed
#2) Change the Status of "NEW" to "In Progress or other" if you spent some hrs on it
#3) If the task is completed then please check the Verifying status and if already verified then please CLOSE it.

#Regards
#NTT DATA OSS Center
#-------------------------------------------------
#This is system genrated mail, please do not reply

#MESSAGE_END

 Net::SMTP.start('localhost') do |smtp|
  	smtp.send_message message, 'yogesh.dhandal@nttdata.com','NTTD_OSS@nttdata.com'
	#smtp.send_message message, 'yogesh.dhandal@nttdata.com','yogesh.dhandal@nttdata.com'


end

	
                             
end