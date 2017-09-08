for dir in image1 image2 image3 image4 image5 image6 image7; do
    mkdir -p /reaper/$dir
    mount reaper:/$dir /reaper/$dir -t nfs -o vers=3,rw,soft,async
done

