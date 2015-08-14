corr <- function(directory, threshold = 0) {
## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'threshold' is a numeric vector of length 1 indicating the
## number of completely observed observations (on all
## variables) required to compute the correlation between
## nitrate and sulfate; the default is 0
        
        ## read folder contents 
        ## we assume the data source is a sub-folder of working directory 
        ## if it is not the case we need to change source_dir formula
        
        source_dir = paste(getwd(),directory,sep="/")
        file_list = list.files(path = source_dir, pattern = "*.csv")
        
        # create a container for final data
        vector = c()
        
        # read the needed files into input container and get observations
        for (j in 1:length(file_list)) 
        { 
                #read file into input container
                tmp_file <- paste(source_dir, file_list[j], sep="/")
                data_input <- data.frame()
                data_input <- read.csv(tmp_file, header = TRUE)
                good <- complete.cases(data_input)
               
                if (nrow(data_input[good,]) >= threshold) {
                        valid_obs <- data_input[good,]
                        vector <- c(vector, cor(valid_obs$sulfate,valid_obs$nitrate))
                    
                        
                }
                
                
        }
        
        
        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
        if (length(vector) == 0) vector <- vector(mode="numeric", length=0)
       
        vector
}
