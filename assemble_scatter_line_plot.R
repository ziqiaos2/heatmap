assemble_scatter_line_plot <- function(DATA_long,GroupColorMatrix,output_directory,select_rows,plot_width,plot_height,xticklabs)
{
    #set what is grouped and what is along the x-axis (these can be switched, but then may not be compatible with the rest of the MakeBoxPlot function)
    sample_on_x_axis = TRUE
    if(sample_on_x_axis)
    {
        x_var <- 'sample'
        y_var <- 'value'
        color_var <- 'gene'
        no_groups_color <- 'grey'
    }

    if(xticklabs){XTickLabels <- NULL}
    if(!xticklabs){XTickLabels <- theme(axis.text.x=element_blank())}

    gene_on_x_axis = FALSE
    if(gene_on_x_axis)
    {
        x_var <- 'gene'
        y_var <- 'value'
        color_var <- 'sample'
        no_groups_color <- 'grey'
    }

    XLabel <- ''
    YLabel <- 'expression'
    TextSize = 8

    pdf_width <- unit(plot_width,'cm')
    pdf_height <- unit(plot_height,'cm')

    #gsp <- geom_point(aes_string(color=color_var,x=x_var,y=y_var))
    gsp = NULL
    glp <- geom_line(aes_string(x=x_var,y=y_var,group=color_var,color=color_var),size=0.5) #the group designation is needed to say that those dots with this group should be connected

    ScatterPlot <-  ggplot(DATA_long) +
      gsp +
      glp +
      theme(axis.text.y=element_text(color='black',size=10)) +
      theme(axis.ticks.y=element_line(colour='black',size=1)) +
      theme(axis.ticks.x=element_line(colour='black',size=1)) +
      theme(axis.text.x=element_text(color='black',size=10)) +
      theme(axis.title.y=element_text(color='black',vjust=1,size=10)) +
      theme(axis.title.x=element_text(color='black',vjust=0,size=10)) +
      theme(panel.background=element_rect(fill=NA)) +
      theme(axis.line.x=element_line(colour='black',size=1,linetype='solid')) +
      theme(axis.line.y=element_line(colour='black',size=1,linetype='solid')) +
      theme(axis.text.x = element_text(angle=90,hjust=1)) +
      theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +#removes gridlines
      theme(legend.title=element_blank()) +
      theme(legend.key=element_rect(fill=NA)) +
      theme(legend.text = element_text(colour="black", size = 6)) +
      theme(legend.key.size = unit(0.3, "cm")) + #Space between legend symbols and text, maybe?
      theme(legend.background = element_rect(fill="transparent",linetype = 0,colour = 'transparent')) +
      XTickLabels

   ggsave(paste(output_directory,'scatterplot.pdf',sep=''), width = pdf_width, height = pdf_height, dpi = 300, limitsize=FALSE)
}
