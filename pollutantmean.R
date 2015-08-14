pollutantmean <- function(directory, pollutant, id = 1:332) {
## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'pollutant' is a character vector of length 1 indicating
## the name of the pollutant for which we will calculate the
## mean; either "sulfate" or "nitrate".

## 'id' is an integer vector indicating the monitor ID numbers
## to be used
        
        
## test if pollutant is valid and then start processing
valid_pollutant <- c("sulfate","nitrate")

chk_pollutant <- is.element(pollutant, valid_pollutant)

if (chk_pollutant == FALSE) {     
                print("Polluttant not valid!")
} else    {       
        
        ## read folder contents 
        ## we assume the data source is a sub-folder of working directory 
        ## if it is not the case we need to change source_dir formula
        
        source_dir = paste(getwd(),directory,sep="/")
        file_list = list.files(path = source_dir, pattern = "*.csv")
        
        ## create a container for data
        data_input <- data.frame()
        
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!
        
        # create a container for data
        data_input <- data.frame()
        
        # read the needed files into data container
        for (j in id) 
        { 
                tmp_file <- paste(source_dir, file_list[j], sep="/")
                data_input <- rbind(data_input, read.csv(tmp_file, header = TRUE))
                
        }
        
        
        ## cleaning the NA's
        bad <- is.na(data_input[[pollutant]])
        pollutant_data <- data_input[[pollutant]][!bad]
        
        ## return the calculated mean value
        return(mean(pollutant_data))
        
        }
}
