USE [msdb]

/*****
INSUFFICIENT PERMISSIONS ALERT

This SQL script will create an alert to notify the team if an account tries to access a database the account doesn't have permissions to.

This is a SQL Server event alert, so it will only execute when the event occurs.

@delay_between_responses	-	this variable is in seconds.  Because this is an event alert there isn't a delay time set.
@performance_condition		-	N/A
@notification_message		-	When the event occurs the server will automatically send an e-mail to a defined Operator and include the account that is trying to access the server.
*****/

DECLARE @operator_name sysname = N'operator name'


EXEC msdb.dbo.sp_update_alert @name = N'Permission Alert', 
		@message_id = 0, 
		@severity = 14, 
		@enabled = 1, 
		@delay_between_responses = 0, 
		@include_event_description_in = 1, 
		@database_name = N'', 
		@notification_message = N'', 
		@event_description_keyword = N'', 
		@performance_condition = N'', 
		@wmi_namespace = N'', 
		@wmi_query = N'', 
		@job_id = N'00000000-0000-0000-0000-000000000000'
;


EXEC msdb.dbo.sp_update_notification @alert_name = N'Permission Alert',
		@operator_name = @operator_name,
		@notification_method = 1
;
