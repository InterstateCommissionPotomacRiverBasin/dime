potomac.df <- sprintf("020700%02d", seq(1, 11, 1)) %>% 
  paste(collapse = ";") %>% 
  whatWQPsites(huc = ., siteType = "Stream")
