assemble_box_plot <- function(DATA_long,FillColors,output_directory,y_bounds)
{
    #set what is grouped and what is along the x-axis (these can be switched, but then may not be compatible with the rest of the MakeBoxPlot function)
    x_var <- 'gene'
    y_var <- 'value'
    color_var <- 'group'
    no_groups_color <- 'grey'

    YLabel <- 'Abundance'
    XLabel <- ''
    TextSize = 8

    pdf_width <- unit(4,'cm')
    pdf_height <- unit(4,'cm')
    bar_width <- 0.50
    inter_group_spacing <- 0.55
    legend_position <- c(0.25,0.9)

    #If there are groups, the group color is specified by the color_var
    if(!is.null(FillColors))
    {
        gbp <- geom_boxplot(aes_string(fill=color_var),outlier.colour='black',outlier.size=0.5,width=bar_width,position=position_dodge(width=inter_group_spacing),outlier.shape=NA,lwd=0.2)
    }

    #If there are no groups, the group color is specified by no_groups_color
    if(is.null(FillColors))
    {
        gbp <- geom_boxplot(outlier.colour='black',outlier.size=0.5,width=bar_width,position=position_dodge(width=inter_group_spacing),outlier.shape=NA,lwd=0.2,fill=no_groups_color)
    }


    b <- ggplot(DATA_long,aes_string(x=x_var, y=y_var)) +
         gbp +
         theme(axis.text.y=element_text(color='black',size=TextSize)) +
         theme(axis.ticks.y=element_line(colour='black',size=0.5)) +
         theme(axis.ticks.x=element_line(colour='black',size=0.5)) +
         theme(axis.text.x=element_text(color='black',size=TextSize,angle=90,hjust=1,vjust=0.5)) +
         theme(axis.title.y=element_text(color='black',vjust=1,size=TextSize)) +
         theme(axis.title.x=element_text(color='black',vjust=0,size=TextSize)) +
         theme(panel.background=element_rect(fill=NA)) +
         theme(axis.line.x=element_line(colour='black',size=0.5,linetype='solid')) +
         theme(axis.line.y=element_line(colour='black',size=0.5,linetype='solid')) +
         theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) + #removes gridlines
         theme(legend.title=element_blank()) +
         theme(legend.background=element_rect(fill=NA)) + #No background color in legend
         theme(legend.key.size=unit(0.3,'cm')) +
         theme(legend.text = element_text(colour="black", size=(TextSize-2))) +
         theme(legend.position=legend_position) +
         scale_fill_manual(values=FillColors) +
         #theme(legend.key.size = unit(0.2, "cm")) +
         labs(x = XLabel) +
         labs(y = YLabel) +
         coord_cartesian(ylim=y_bounds) #this must be placed inside coord_cartesian() so points outside of the limits are not discarded in calculating medians and IQRs
         #aes_string() allows the factors to be specified by strings and ensures they are evaluated within the correct environment (aes() causes all sorts of trouble)

    ggsave(paste(output_directory,'boxplot.pdf',sep=''), width = pdf_width, height = pdf_height, dpi = 300, limitsize=FALSE)
    return(b)
}