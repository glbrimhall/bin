for dir in image1 image2 image3 image4 image5; do
    mkdir -p /reaper/$dir
    mount -t smbfs //reaper/$dir /reaper/$dir -o username=geoff,password=fox4tails
done

