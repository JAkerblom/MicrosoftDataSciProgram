CREATE TABLE dbo.usql_logs 
		(
				log_date varchar(12), 
				requests int, 
				bytes_in float, 
				bytes_out float
		);

SELECT * FROM dbo.usql_logs;