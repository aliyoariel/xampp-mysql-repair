@echo off

set /p dirPath="Paste your MYSQL path (ex: C:\xampp\mysql): "
:: Check if the input path ends with "\mysql"
if "%dirPath:~-7%" neq "\mysql" (
    :: Check if the MYSQL folder exists
    if exist "%dirPath%" (
        :: Check if the backup folder exists
        if exist "%dirPath%\backup" (
            :: Check if the data folder exists
            if exist "%dirPath%\data" (
                :: Copy the backup folder to the data folder
                echo "Deleted: file and folders"
                del /s /q "%dirPath%\data\aria_log.00000001"
                del /s /q "%dirPath%\data\aria_log_control"
                del /s /q "%dirPath%\data\ibtmp1"
                del /s /q "%dirPath%\data\ib_buffer_pool"
                del /s /q "%dirPath%\data\ib_logfile0"
                del /s /q "%dirPath%\data\ib_logfile1"
                del /s /q "%dirPath%\data\multi-master.info"
                del /s /q "%dirPath%\data\my.ini"
                rd /s /q "%dirPath%\data\mysql"
                rd /s /q "%dirPath%\data\performance_schema"
                rd /s /q "%dirPath%\data\phpmyadmin"

                
                echo "Copying: file and folders"
                copy "%dirPath%\backup\aria_log.00000001" "%dirPath%\data\aria_log.00000001"
                copy "%dirPath%\backup\aria_log_control" "%dirPath%\data\aria_log_control"
                copy "%dirPath%\backup\ibtmp1" "%dirPath%\data\ibtmp1"
                copy "%dirPath%\backup\ib_buffer_pool" "%dirPath%\data\ib_buffer_pool"
                copy "%dirPath%\backup\ib_logfile0" "%dirPath%\data\ib_logfile0"
                copy "%dirPath%\backup\ib_logfile1" "%dirPath%\data\ib_logfile1"
                copy "%dirPath%\backup\multi-master.info" "%dirPath%\data\multi-master.info"
                copy "%dirPath%\backup\my.ini" "%dirPath%\data\my.ini"
                xcopy "%dirPath%\backup\mysql" "%dirPath%\data\mysql" /s /y /i /e
                xcopy "%dirPath%\backup\performance_schema" "%dirPath%\data\performance_schema" /s /y /i /e
                xcopy "%dirPath%\backup\phpmyadmin" "%dirPath%\data\phpmyadmin" /s /y /i /e
                echo.
                echo "MySQL database repaired successfully!"
                echo.
                echo "Start MySQL from XAMPP control panel"
                echo "This step cannot be automated directly from a batch script as it requires user interaction with the XAMPP control panel."
                echo "Please manually start MySQL from the XAMPP control panel after running this script."
            ) else (
                :: Copy the backup folder to the data folder
                xcopy "%dirPath%\backup" "%dirPath%\data" /s /y /i /e
                echo.
                echo "Data folder not found!"
                echo.
                echo "Start MySQL from XAMPP control panel"
                echo "This step cannot be automated directly from a batch script as it requires user interaction with the XAMPP control panel."
                echo "Please manually start MySQL from the XAMPP control panel after running this script."
            )
        ) else (
            echo "Backup folder not found!"
        )
    ) else (
        echo "MYSQL folder not found at %dirPath% !"
    )
) else (
    echo "%dirPath% is not a valid MYSQL folder!"
)
pause
