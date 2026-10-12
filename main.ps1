. ./logging.ps1

try {. ./config.ps1
}

#load the config file and check for errors. If there are errors, log them and exit the script
catch {
    log_error "Error loading config.ps1: $_"
    exit 1
}

log_info "----SCRIPT STARTED---"

# PRE FLIGHT CHECKS

################################################################################## section one
#Check that the config file has the correct structure and types for each key
foreach ($key in $dirs.Keys) {

        $path = $dirs[$key].path
        $keep_last = $dirs[$key].keep_last

        if ($keep_last.GetType().Name -ne "Int32"){

            log_error "Keep_last must be an integer. Please check the config file for $key"
            exit 1
        }
        if (($path -eq $null) -or ($path -eq "") -or ($path.GetType().Name -ne "String")) {

            log_error "Path cannot be null or empty and must be a string. Please check the config file for $key"
            exit 1
        }


}

foreach ($key in $dirs.Keys) {

        $path = $dirs[$key].path
        $keep_last = $dirs[$key].keep_last

        if (Test-Path $path) {
            log_success "Directory $path exists. Proceeding with the rest of the script"

            if(($keep_last -gt 0) -and ($keep_last.GetType().Name -eq "Int32")) {

                # The default sort is oldest to newest, so the oldest files are at the beginning
                $files = Get-ChildItem -Path $path | Sort-Object -Property CreationTime

                # Calculate the number of files to delete
                $files_to_delete_count = $files.Count - $keep_last

                log_info "File count: $($files.Count)"
                log_info "Backups to keep: $keep_last"
                log_info "Files to delete count: $files_to_delete_count"
                #Check that $files_to_delete_count not equal $file.count
                if ($files_to_delete_count -gt 0) {

                        # Select the first 'N' files (the oldest ones) to be deleted
                        $files_to_delete = $files | Select-Object -First $files_to_delete_count

                        # Loop through the selected files and delete them
                        foreach ($file in $files_to_delete) {
                            Remove-Item -Path $file.FullName -Force
                            log_info "Deleting old files: $file, retention policy: $keep_last"
                        }
                    }

                else {
                        log_info "No files to delete, retention policy: $keep_last"
                }
            }

            else {

                log_warn "Keep_last cannot be less than or equal to 0. I must be an integer. No files will be deleted."
            }
        }

        else {
            log_error "Directory $path does not exist."
        }
}

log_info "----SCRIPT FINISHED----"
