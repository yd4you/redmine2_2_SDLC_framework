#!/usr/local/bin/ruby

require "rubygems"  
require "mysql"
require 'net/smtp'
require 'date'

begin
    con = Mysql.new 'localhost', 'root', 'passwd@vtx0', 'redmine_production'
    outputstr = String.new("")
    sqlstr = String.new("")
    startDt = Date.today
    endDt = Date.today + 16

    sqlstr = sqlstr.concat("select distinct w.holiday, IF(u.firstname = 'NTTD OSS India','India Holiday',IF(u.firstname='NTTD OSS Japan','Japan Holiday',concat(u.firstname, ' ', u.lastname))) as `name` from wt_holidays w ")
    sqlstr = sqlstr.concat("left join users u ")
    sqlstr = sqlstr.concat("on w.created_by = u.id ")
    sqlstr = sqlstr.concat("where deleted_on Is Null And u.firstname Is Not Null ") 
#    sqlstr = sqlstr.concat("and `w`.holiday between STR_TO_DATE('01/01/2014', '%m/%d/%Y') and STR_TO_DATE('02/01/2014', '%m/%d/%Y')")

    sqlstr = sqlstr.concat("and `w`.holiday between STR_TO_DATE('#{startDt.strftime("%m/%d/%Y")}', '%m/%d/%Y') and STR_TO_DATE('#{endDt.strftime("%m/%d/%Y")}', '%m/%d/%Y')")
    sqlstr = sqlstr.concat(" order by w.holiday asc, u.firstname asc, u.lastname asc ") 

# puts sqlstr 

    rs = con.query(sqlstr)
    n_rows = rs.num_rows

#    puts "There are #{n_rows} rows in the result set"

	outputstr = outputstr.concat("-------------------------------------------\n")    
	outputstr = outputstr.concat(" Leave Date\t|\tName\n")
	outputstr = outputstr.concat("-------------------------------------------\n")

    n_rows.times do
       outputstr = outputstr + rs.fetch_row.join("\t|\t")
	outputstr = outputstr + "\n"
    end
#	puts outputstr
rescue Mysql::Error => e
    puts e.errno
    puts e.error

ensure
    con.close if con
end

if n_rows > 0
message = <<MESSAGE_END
From: RedmineAdmin-NoReply@OSSProjectManager.com
To: yogesh.dhandal@nttdata.com; oss.support@kits.nttdata.co.jp; ossci-db-all@swh.nttdata.co.jp; ossci-pf-all@swh.nttdata.co.jp; oss_mig_gag@kits.nttdata.co.jp;
cc: NTTD.OSSCoreGroup@nttdata.com; NTTD_OSS@nttdata.com;
Subject: OSS : Holiday and Leave Plan for Next 15 Days

Dear All

Holiday list and Leave plan of OSS members for next 15 days

#{outputstr}


Note : Those who haven't applied leave in Redmine, request you all to apply immediately.

Regards
NTT DATA OSS Center
-------------------------------------------------
This is system generated mail, please do not reply
[This mail will be generated on every Monday.]


MESSAGE_END


 Net::SMTP.start('localhost') do |smtp|
  smtp.send_message message, 'yogesh.dhandal@nttdata.com' ,
                             ['yogesh.dhandal@nttdata.com'],['NTTD_OSS@nttdata.com','NTTD.OSSCoreGroup@nttdata.com','oss.support@kits.nttdata.co.jp',
					'ossci-db-all@swh.nttdata.co.jp','ossci-db-all@swh.nttdata.co.jp','ossci-pf-all@swh.nttdata.co.jp','oss_mig_gag@kits.nttdata.co.jp',
					'Pankaj.Gaba@nttdata.com','Nagappan.Palaniappan@nttdata.com']
 end
end

