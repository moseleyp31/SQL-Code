USE [msdb]

/*****
BLOCKED PROCESSES ALERT

This SQL script will create an alert to notify the team if more than 1 blocked process is found on the server.

This alert will check every 30 minutes for more than 1 blocked process on the server.

@delay_between_responses	-	this variable is in seconds.  In this example it is set to 1800, or 30 minutes.  Adjust as desired.
@performance_condition		-	this is set for more than 1.  As ETL processes run, it's not uncommon for processes to 
	be blocked, but usually the blocking is brief.  Typically, only a few minutes at most.  This is why the Alert
	is set up to check every 30 minutes.  Adjust as desired.
@notification_message		-	If more than 1 process is found to be blocked, the server will automatically send an e-mail to a defined Operator.
*****/

DECLARE @operator_name sysname = N'operator name'

EXEC msdb.dbo.sp_add_alert @name=N'Blocked Processes on <server name>', 
		@message_id = 0, 
		@severity = 0, 
		@enabled = 1, 
		@delay_between_responses = 1800, 
		@include_event_description_in = 1, 
		@database_name = N'', 
		@notification_message = N'Blocked Processes Alert', 
		@event_description_keyword = N'', 
		@performance_condition = N'General Statistics|Processes blocked||>|1', 
		@wmi_namespace = N'', 
		@wmi_query = N'', 
		@job_id = N'00000000-0000-0000-0000-000000000000'
;

EXEC msdb.dbo.sp_add_notification @alert_name = N'Blocked Processes on <server name>',
		@operator_name = @operator_name,
		@notification_method = 1
;
