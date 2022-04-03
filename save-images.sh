CHART_PATH=$1
CHART_NAME=$2

IMAGES=`helm template "$CHART_NAME" "$CHART_PATH" --set certmanager-issuer.email=a@a.a | grep image: | sed "s/image: //g" | sed 's/"//g' | sort --unique`
for image in $IMAGES; do 
    repo=`echo $image | cut -d ":" -f1`
    # tag=`echo $image | cut -d ":" -f2 | cut -d "@" -f1`
    # hash=""
    # if echo $image | grep '@'; 
    # then
    #     hash=`echo $image | cut -d "@" -f2`
    # else 
    #     echo $image
    # fi 
    echo "Pulling $repo"
    docker pull $image > /dev/null
done

docker save $IMAGES -o ./$CHART_NAME.tar
