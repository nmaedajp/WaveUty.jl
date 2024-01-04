# 多チャンネルをプロットするための関数．GMT.jlを使用している．
# Wavetype を使用しない版
function plot_mch(wave, nwave, nch, chid, hz, t1, t2, y1, y2, title;
    width=16, height=1.0, offset=0.9, szmj=10, pw=0.25, 
    szttl=12, szlbl=10, szleg=10, 
    xlabel="time [s]",unit="[m/s@+2@+]",
    )
#
#  wave[1:nwave, 1:nch] 
#
    dt = 1.0/hz
    t = 0.0:dt:(nwave-1)*dt
# set title
    ttl = title
# set y1 & y2
    nt1 = Int64(round(t1*hz))+1; 
    nt2 = Int64(round(t2*hz))+1; @show nt1,nt2
    if y1 == 0.0 && y2 == 0.0
        y1 = -maximum(abs.(wave[nt1:nt2,:]))
        y2 =  maximum(abs.(wave[nt1:nt2,:]))
    end
# ch 1    
    if nch > 1
      plot(t, wave[1:nwave,1], 
        frame=(axes=(:left_full,:bottom_full,:right_bare,:top_bare), annot=:a,
        ticks=:a, grid=:a),
#    xaxis=(annot=:auto, ticks=:auto, grid=:auto),
#    yaxis=(annot=:auto, ticks=:auto, grid=:auto),
        region=(t1, t2, y1, y2), 
        ylabel=unit,
        title=ttl, 
        pen=(pw,:black),
        J="X$(width)c/$(height)c",
        conf=(FONT_TITLE="$(szttl)p,Helvetica,black", 
          FONT_LABEL="$(szlbl)p,Helvetica,black", 
          FONT_ANNOT_PRIMARY="$(szmj)p,Helvetica,black",
          MAP_ANNOT_OFFSET="2p",
          MAP_TITLE_OFFSET="12p",
          MAP_FRAME_PEN="0.5p,black")
        )
      legend((
	       vspace=-0.25,
           text1=(txt=chid[1]),
          ),
          pos=(norm=(0,1), width=3.5, justify=:BL, offset=0.05, spacing=0.1),
          conf=(FONT_ANNOT_PRIMARY="$(szleg)p,Helvetica,black",)
          )
# ch ich
      for ich = 2:nch-1
        plot(t, wave[1:nwave,ich], 
        frame=(axes=(:left_full,:bottom_full,:right_bare,:top_bare), annot=:a,
        ticks=:a, grid=:a),
#        xaxis=(annot=:auto, ticks=:auto, grid=:auto),
#        yaxis=(annot=:auto, ticks=:auto, grid=:auto),
        region=(t1,t2,y1,y2), 
        ylabel=unit,
        pen=(pw,:black),
        J="X$(width)c/$(height)c",
        Y="-$(offset+height)",
        conf=(FONT_LABEL="10p,Helvetica,black",
              FONT_ANNOT_PRIMARY="$szmj,Helvetica,black",
              MAP_FRAME_PEN="0.75p,black")
        )
        legend((
            vspace=-0.25,
            text1=(text=chid[ich])
           ),
           pos=(norm=(0,1), width=3.5, justify=:BL, offset=0.05, spacing=0.1),
           conf=(FONT_ANNOT_PRIMARY="10p,Helvetica,black",)
           )
      end
    end
# ch nch
    plot(t, wave[1:nwave, nch], 
    frame=(axes=(:left_full,:bottom_full,:right_bare,:top_bare), annot=:a,
    ticks=:a, grid=:a),
#    xaxis=(annot=:auto, ticks=:auto, grid=:auto),
#    yaxis=(annot=:auto, ticks=:auto, grid=:auto),
    region=(t1 ,t2, y1, y2), 
    xlabel=xlabel, 
    ylabel=unit,
    pen=(pw,:black),
    J="X$(width)c/$(height)c",
    Y="-$(offset+height)",
    conf=(FONT_LABEL="10p,Helvetica,black",
         FONT_ANNOT_PRIMARY="$(szmj)p,Helvetica,black",
         MAP_FRAME_PEN="0.75p,black"),
    time_stamp=""
    )
    legend((
        vspace=-0.25,
        text1=(text=chid[nch])
       ),
       pos=(norm=(0,1), width=3.5, justify=:BL, offset=0.05, spacing=0.1),
       conf=(FONT_ANNOT_PRIMARY="10p,Helvetica,black",)
       )
end
