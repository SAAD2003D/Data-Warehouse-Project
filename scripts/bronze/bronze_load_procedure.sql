USE [Sales_Data_Warehouse]
GO
/****** Object:  StoredProcedure [bronze_layer].[load_bronze]    Script Date: 23/02/2025 15:04:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

ALTER   procedure [bronze_layer].[load_bronze] as 
begin 
         declare @start_time DATETIME , @batch_start_time DATETIME ,@batch_end_time DATETIME ,@end_time DATETIME;
		 BEGIN TRY 
		       SET @batch_start_time= GETDATE();
			   PRINT'=============================================';
			   PRINT'Loading Bronze Layer';
			   PRINT'----------------------------------------------------------------';
			   PRINT'Loading CRM Tables';
			   print'-----------------------------------------------------------------';
			   SET @start_time = GETDATE();
			   PRINT '>> Truncating Table : bronze_layer.crm_cust_info';
			   TRUNCATE TABLE bronze_layer.crm_cust_info;
			   PRINT'INSERTING DATA INTO : bronze_layer.crm_cust_info';
			   BULK INSERT bronze_layer.crm_cust_info FROM
			   'D:\Data-Engineering101\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			   WITH (   
			              FIRSTROW=2,
						  FIELDTERMINATOR=',',
						  TABLOCK 
						  );
			   SET @end_time =GETDATE();
			   PRINT '>> Load Duration : '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
			   PRINT '>> ---------------------------------------';
			   SET @start_time =GETDATE() ;
			   PRINT '>> Truncating Table : bronze_layer.crm_prd_info';
			   TRUNCATE TABLE bronze_layer.crm_prd_info;
			   PRINT'INSERTING DATA INTO : bronze_layer.crm_prd_info';
			   BULK INSERT bronze_layer.crm_prd_info FROM
			   'D:\Data-Engineering101\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			   WITH (   
			              FIRSTROW=2,
						  FIELDTERMINATOR=',',
						  TABLOCK 
						  );
			   SET @end_time =GETDATE();
			   PRINT '>> Load Duration : '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
			   PRINT '>> ---------------------------------------';
			    PRINT '>> Truncating Table : bronze_layer.crm_sales_details';
			   TRUNCATE TABLE bronze_layer.crm_cust_info;
			   PRINT'INSERTING DATA INTO : bronze_layer.crm_sales_details';
			   BULK INSERT bronze_layer.crm_sales_details FROM
			   'D:\Data-Engineering101\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			   WITH (   
			              FIRSTROW=2,
						  FIELDTERMINATOR=',',
						  TABLOCK 
						  );
			   SET @end_time =GETDATE();
			   PRINT '>> Load Duration : '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
			   PRINT '>> ---------------------------------------';
			   PRINT'Loading ERP Tables';
			   print'-----------------------------------------------------------------';
			   SET @start_time = GETDATE();
			   PRINT '>> Truncating Table : bronze_layer.erp_cust_az12';
			   TRUNCATE TABLE bronze_layer.erp_cust_az12;
			   PRINT'INSERTING DATA INTO : bronze_layer.erp_cust_az12';
			   BULK INSERT bronze_layer.erp_cust_az12 FROM
			   'D:\Data-Engineering101\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			   WITH (   
			              FIRSTROW=2,
						  FIELDTERMINATOR=',',
						  TABLOCK 
						  );
			   SET @end_time =GETDATE();
			   PRINT '>> Load Duration : '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
			   PRINT '>> ---------------------------------------';
			   SET @start_time = GETDATE();
			   PRINT '>> Truncating Table : bronze_layer.erp_loc_a101';
			   TRUNCATE TABLE bronze_layer.erp_loc_a101;
			   PRINT'INSERTING DATA INTO : bronze_layer.erp_loc_a101';
			   BULK INSERT bronze_layer.erp_loc_a101 FROM
			   'D:\Data-Engineering101\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
			   WITH (   
			              FIRSTROW=2,
						  FIELDTERMINATOR=',',
						  TABLOCK 
						  );
			   SET @end_time =GETDATE();
			   PRINT '>> Load Duration : '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
			 
			   PRINT '>> ---------------------------------------';
			   SET @start_time = GETDATE();
			   PRINT'>> Truncating Table : bronze_layer.erp_px_cat_g1v2';
			   TRUNCATE TABLE bronze_layer.erp_px_cat_g1v2;
			   PRINT'INSERTING DATA INTO : bronze_layer.erp_px_cat_g1v2';
			   BULK INSERT bronze_layer.erp_px_cat_g1v2 FROM
			   'D:\Data-Engineering101\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
			   WITH (   
			              FIRSTROW=2,
						  FIELDTERMINATOR=',',
						  TABLOCK 
						  );
			   SET @end_time =GETDATE();
			   PRINT '>> Load Duration : '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
			   PRINT '>> ---------------------------------------';
		       SET @batch_end_time =GETDATE() ;
			   PRINT 'Loading Bronze Layer is completed ';
			   PRINT 'Total Load Duration : ' + CAST(DATEDIFF(SECOND,@batch_start_time , @batch_end_time) AS NVARCHAR) + ' seconds';
			   PRINT '====================================================';
			   END TRY 
			   BEGIN CATCH
			   PRINT '=========================================='
		       PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		       PRINT 'Error Message' + ERROR_MESSAGE();
		       PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		       PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		       PRINT '=========================================='
	           END CATCH
END
			   

execute bronze_layer.load_bronze ;