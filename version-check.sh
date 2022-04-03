CHART_PATH=$1
CHART_NAME=$2
TARGET_PATH=$3

IMAGES=`helm template "$CHART_NAME" "$CHART_PATH" --set certmanager-issuer.email=a@a.a | grep image: | sed "s/image: //g" | sed 's/"//g' | sort --unique`
for image in $IMAGES; do 
    # repo=`echo $image | cut -d ":" -f1`
    # tag=`echo $image | cut -d ":" -f2 | cut -d "@" -f1`
    # hash=""
    # if echo $image | grep '@'; 
    # then
    #     hash=`echo $image | cut -d "@" -f2`
    # else 
    #     echo $image
    # fi 
    docker pull $image
done

docker save $(sudo docker images | awk '/a/ {print $1 ":" $2}') -o $TARGET_PATH
