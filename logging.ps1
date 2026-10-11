function log_info {

    param(
        [string]$Message
    )
    $date = get-date -Format "dd/MM/yyyy hh:mm:ss"
    $LOGFILE = 'log.txt'
    "$date $Message" | Out-File $LOGFILE -Append -Encoding ascii
    Write-Host "$date [INFO] $Message" -ForegroundColor Cyan
}

function log_error {

    param(
        [string]$Message
    )
    $date = get-date -Format "dd/MM/yyyy hh:mm:ss"
    $LOGFILE = 'log.txt'
    "$date $Message" | Out-File $LOGFILE -Append -Encoding ascii
    Write-Host "$date [ERROR] $Message" -ForegroundColor Red
}

function log_success {

    param(
        [string]$Message
    )
    $date = get-date -Format "dd/MM/yyyy hh:mm:ss"
    $LOGFILE = 'log.txt'
    "$date $Message" | Out-File $LOGFILE -Append -Encoding ascii
    Write-Host "$date [SUCCESS] $Message" -ForegroundColor Green
}

function log_warn {

    param(
        [string]$Message
    )
    $date = get-date -Format "dd/MM/yyyy hh:mm:ss"
    $LOGFILE = 'log.txt'
    "$date $Message" | Out-File $LOGFILE -Append -Encoding ascii
    Write-Host "$date [WARNING] $Message" -ForegroundColor Yellow
}

function log_debug {

    param(
        [string]$Message
    )
    $date = get-date -Format "dd/MM/yyyy hh:mm:ss"
    $LOGFILE = 'log.txt'
    "$date $Message" | Out-File $LOGFILE -Append -Encoding ascii
     Write-Host "$date [DEBUG] $Message" -ForegroundColor Magenta -BackgroundColor White
}