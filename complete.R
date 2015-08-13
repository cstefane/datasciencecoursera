complete  <- function(directory, id) {
## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'id' is an integer vector indicating the monitor ID numbers
## to be used


        ## read folder contents 
        ## we assume the data source is a sub-folder of working directory 
        ## if it is not the case we need to change source_dir formula
        
        source_dir = paste(getwd(),directory,sep="/")
        file_list = list.files(path = source_dir, pattern = "*.csv")

        
        # create a container for final data
        df_complete <- data.frame()
        
        # read the needed files into input container and get observations
        for (j in id) 
        { 
                #read file into input container
                tmp_file <- paste(source_dir, file_list[j], sep="/")
                data_input <- data.frame()
                data_input <- read.csv(tmp_file, header = TRUE)
                good <- complete.cases(data_input)
                
                
                # store observations in final container
                newRow <- c(j,nrow(data_input[good,]))
                df_complete <- rbind(df_complete,newRow)

        }
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
        
        colnames(df_complete) <- c("id", "nobs")
        df_complete

}
