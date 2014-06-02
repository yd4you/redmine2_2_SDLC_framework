#!/usr/local/bin/ruby

require "rubygems"
require "mysql"
require 'net/smtp'
require 'date'

begin
    con = Mysql.new 'localhost', 'root', 'xxxxx', 'redmine_production'
    outputstr = String.new("")
    outputstr1 = String.new("")
    sqlstr = String.new("")
    startDt = Date.today+1
    endDt = Date.today + 16
    emailid = String.new("")
    tempemailid = String.new("")


			sqlstr = sqlstr.concat("     select   ")
			sqlstr = sqlstr.concat("      id.issue_id,id.estimated_end_date,id.due_date,`id`.`status` ,id.`Delay Informed`, id.`Delay Communication Date`, IFNULL(id.UserName, 'Team Leader') UserName, ")
			sqlstr = sqlstr.concat("      id.projectName,id.tracker, id.`Delay Reason`   ")
			sqlstr = sqlstr.concat("     from     ")
			sqlstr = sqlstr.concat("     (     ")
			sqlstr = sqlstr.concat("      select i.root_id, i.id as `issue_id`,     ")
			sqlstr = sqlstr.concat("        tk.name as `tracker`, i.project_id, p.projectName as `ProjectName`,     ")
			sqlstr = sqlstr.concat("       s.name as `Status`, i.subject, us.login,     ")
			sqlstr = sqlstr.concat("       CONCAT(us.firstname, ' ', us.lastname) as `UserName`, us.mail,   ")
			sqlstr = sqlstr.concat("       CAST(cv1.value as CHAR) as `estimated_end_date` , i.start_date ,i.due_date   ")
			sqlstr = sqlstr.concat("  ,isParentExist(i.id) as flg , `slaDelay1`.value as `Delay Informed`, `slaDelayDate`.value as `Delay Communication Date`, `slaDelayRsn`.value as `Delay Reason` ")
			sqlstr = sqlstr.concat("      from issues As i     ")
			sqlstr = sqlstr.concat("      LEFT OUTER JOIN `issue_statuses` AS `s` ON `i`.`status_id` = `s`.`id`     ")
			sqlstr = sqlstr.concat("        INNER JOIN (   ")
			sqlstr = sqlstr.concat("         SELECT p.id, p.name as `projectName`     ")
			sqlstr = sqlstr.concat("         FROM projects AS p   ")
			sqlstr = sqlstr.concat("         where p.id not in (7,8,9,11,12,15,51,31,35,49,37,50)   ")
			sqlstr = sqlstr.concat("        ) `p` on i.project_id = p.id     ")
			sqlstr = sqlstr.concat("        LEFT OUTER JOIN     ")
			sqlstr = sqlstr.concat("         ( select * from `custom_values` AS `cv` where cv.custom_field_id = 34 ) as `cv`   ")
			sqlstr = sqlstr.concat("         ON `i`.`id` = `cv`.`customized_id`   ")
			sqlstr = sqlstr.concat("        LEFT OUTER JOIN   ")
			sqlstr = sqlstr.concat("         ( select * from `custom_values` AS `cv` where cv.custom_field_id = 54 ) AS `cv1` ON `i`.`id` = `cv1`.`customized_id`   ")
			sqlstr = sqlstr.concat("        LEFT OUTER JOIN   ")
			sqlstr = sqlstr.concat("         ( select * from `custom_values` AS `cv` where cv.custom_field_id = 92 ) AS `slaDelay1` ON `i`.`id` = `slaDelay1`.`customized_id`   ")
			sqlstr = sqlstr.concat("        LEFT OUTER JOIN   ")
			sqlstr = sqlstr.concat("         ( select * from `custom_values` AS `cv` where cv.custom_field_id = 93 ) AS `slaDelayDate` ON `i`.`id` = `slaDelayDate`.`customized_id`   ")
			sqlstr = sqlstr.concat("        LEFT OUTER JOIN   ")
			sqlstr = sqlstr.concat("         ( select * from `custom_values` AS `cv` where cv.custom_field_id = 94 ) AS `slaDelayRsn` ON `i`.`id` = `slaDelayRsn`.`customized_id`   ")
			sqlstr = sqlstr.concat("        left outer JOIN `users` as `us` ON `i`.`assigned_to_id` = `us`.`id`   ")
			sqlstr = sqlstr.concat("        LEFT OUTER JOIN `trackers` as `tk` ON `i`.`tracker_id` = `tk`.`id`     ")
			sqlstr = sqlstr.concat("     ) as `id`     ")
			sqlstr = sqlstr.concat("     where id.tracker like 'User Story' and `id`.`status` in ('New','In Progress','Open')   ")
			sqlstr = sqlstr.concat("     and ( (id.estimated_end_date < id.due_date) or (id.estimated_end_date is null or trim(id.estimated_end_date) = '') )   ")
			sqlstr = sqlstr.concat("     order by id.project_id asc, id.mail, id.issue_id asc   ")



 # puts sqlstr

    rs = con.query(sqlstr)
    n_rows = rs.num_rows

    puts "There are #{n_rows} rows in the result set"
#id.issue_id, id.`Total_Spent_Hrs`, id.`Remaining_Hrs`, id.done_ratio as `% Completed`,id.`Status`, IFNULL(id.UserName, 'Team Leader') UserName,id.projectName,id.tracker
        outputstr = outputstr.concat("--------------------------------------------- Header -----------------------------------------------------------------------------------------------------------------------------------\n")
        outputstr = outputstr.concat("Issue ID    |  Estimated End Date   |  Due Date\t|  Status   |  Delay Informed   |  Delay Communication Date  | User Name |  Project Name  |  Tracker   |   Delay Reason\n")
        outputstr = outputstr.concat("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n")

        # For loop for each record
    n_rows.times do
         outputstr = outputstr + rs.fetch_row.join("\t|\t")
         outputstr = outputstr + "\n"
    end



rescue Mysql::Error => e
    puts e.errno
    puts e.error

ensure
    con.close if con
end

if n_rows > 0 || n_rows1 > 0
message = <<MESSAGE_END
From: RedmineAdmin-NoReply@xxxxxx.com
To: xxxx@xxx.com
Subject: SLA Delay Check - Task list

Dear All

Following are the tasks need to be corrected with respective to following issues
1) Due Date > Estimated End Date.. so request you to check
whether any changes in Scope.
2) If any change in scope then change the Estimated End Date in Redmine with proper comments
3) If it is getting delayed then INFORM Client about delay with proper mitigation plan. [DO NOT CHANGE ESTIMATED END DATE]

#{outputstr}



Regards
XXXXXXXXXXX
-------------------------------------------------
This is system genrated mail, please do not reply


MESSAGE_END

end

 Net::SMTP.start('localhost') do |smtp|
  	smtp.send_message message, 'xx@xxx.com','xxxxx@xxxxx.com'

                             
end