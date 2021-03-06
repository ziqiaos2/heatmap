MakeScatterPlot <- function(data_location,ColGroupsScheme=NULL,transformation=NULL,data=NULL,select_rows=NULL,select_groups=NULL,replicate_scheme=NULL,ddt=NULL,med_norm=FALSE,handle_blanks='remove_row')
{
  #Extract the data required to make a scatter plot
  ArrangeData_return <- ArrangeData(ColGroupsScheme,replicate_scheme,transformation,data,data_location,select_rows,select_groups,visualization='scatterplot',ddt,med_norm,handle_blanks)
  sig_test_list <- ArrangeData_return[[1]]
  output_directory <- ArrangeData_return[[2]]
  group_order <- ArrangeData_return[[3]]
  gene_name <- ArrangeData_return[[4]]
  DATA_long <- ArrangeData_return[[5]]
  FillColors <- ArrangeData_return[[6]]
  DATA <- ArrangeData_return[[7]]
  GroupColorMatrix <- ArrangeData_return[[8]]
  groups_corresponding <- ArrangeData_return[[9]]

  #Make the scatter plot
  b <- assemble_scatter_plot(DATA,GroupColorMatrix,output_directory,select_rows)
}
