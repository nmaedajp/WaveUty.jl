# 整数配列６個（年月日時分秒）のデータから，日付の文字列を作成する．
# Dates.formatで可能だが，あまり他のパッケージは使いたくない．
function it2cht(it)
    cht="$(it[1])-$(it[2])-$(it[3])T$(it[4]):$(it[5]):$(it[6]).00"
    return cht
end
# 多チャンネルをプロットするための関数．GMT.jlを使用している．
function plot_mch(wave, t1, t2, y1, y2, title;
    width=16, height=1.0, offset=0.9, szmj=10, pw=0.25, 
    szttl=12, szlbl=10, szleg=10, 
    xlabel="time [s]",unit="[m/s@+2@+]",
    plt_t0=1)
#
    dt = 1.0/wave.hz
    nwave = wave.nwave
    t = 0.0:dt:(nwave-1)*dt
# set title
    if plt_t0 == 1
        ttl = title*"  t0="*it2cht(wave.headtime)
    else
        ttl=title
    end
# set y1 & y2
    if y1 == 0.0 && y2 == 0.0
        y1 = -maximum(abs.(wave.waveF)); y2 = maximum(abs.(wave.waveF))
    end
# ch 1    
    plot(t, wave.waveF[1:nwave,1], 
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
          MAP_FRAME_PEN="1p,black")
    )
    legend((
	       vspace=-0.25,
           text1=(txt="ch "*wave.chid[1]),
          ),
          pos=(norm=(0,1), width=3.5, justify=:BL, offset=0.05, spacing=0.1),
          conf=(FONT_ANNOT_PRIMARY="$(szleg)p,Helvetica,black",)
          )
# ch ich
    for ich = 2:wave.nch-1
        plot(t, wave.waveF[1:nwave,ich], 
        frame=(axes=(:left_full,:bottom_full,:right_bare,:top_bare), annot=:a,
        ticks=:a, grid=:a),
#        xaxis=(annot=:auto, ticks=:auto, grid=:auto),
#        yaxis=(annot=:auto, ticks=:auto, grid=:auto),
        region=(t1,t2,y1,y2), 
        ylabel=unit,
        pen=(pw,:black),
        J="X$(width)c/$(height)c",
        Y="-$(offset+height)",
        conf=(FONT_LABEL="10p,Helvetica,black",FONT_ANNOT_PRIMARY="$szmj,Helvetica,black")
        )
        legend((
            vspace=-0.25,
            text1=(text="ch "*wave.chid[ich])
           ),
           pos=(norm=(0,1), width=3.5, justify=:BL, offset=0.05, spacing=0.1),
           conf=(FONT_ANNOT_PRIMARY="10p,Helvetica,black",)
           )
    end
# ch nch
    plot(t, wave.waveF[1:nwave,wave.nch], 
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
         FONT_ANNOT_PRIMARY="$(szmj)p,Helvetica,black"),
    time_stamp=""
    )
    legend((
        vspace=-0.25,
        text1=(text="ch "*wave.chid[wave.nch])
       ),
       pos=(norm=(0,1), width=3.5, justify=:BL, offset=0.05, spacing=0.1),
       conf=(FONT_ANNOT_PRIMARY="10p,Helvetica,black",)
       )
end
