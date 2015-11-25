#declare -a SRCS=(/media/canonSDCard/DCIM/100CANON/ /media/usbDriveA/DropboxPhoneUploads/)
SRC=/media/canonSDCard/DCIM/100CANON/
DEST=/media/usbDriveA/Photos/

if [ ! -d "$SRC" ]
  echo "$SRC doesn't exixt";
  exit 1;
fi

if [ ! -d "$DEST" ]
  echo "$DEST doesn't exixt";
  exit 1;
fi

if [ "$(ls -A $SRC)" ]; then
 cd $SRC
 #exiftool -r -d $DEST/%Y/%m-%d-RAW/%Y%m%d-%H%M%S.%%e "-FileName<DateTimeOriginal" -ext CR2 $SRC
 exiftool -r -v '-Directory<DateTimeOriginal' -d $DEST/%Y/%m-%d-%%e $SRC
else
 echo "No photos found"
fi
