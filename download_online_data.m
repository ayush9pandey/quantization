function signal = download_online_data(channel, T, fs)
    conn = nds2.connection('192.168.113.202', 8088);
    conn.iterate(channel);
    
    for i = 1:T
        
        bufs = conn.next();
        signal((i-1)*fs + 1 : i*fs) = bufs(1).getData();
    end
end