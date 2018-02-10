/**
 * Created by max.rozdobudko@gmail.com on 2/9/18.
 */
package com.github.airext.notification {
import flash.filesystem.File;

public class NotificationSound {

    // Constructor

    public function NotificationSound(named: String) {
        super();
        _named = named;
    }

    // named

    private var _named: String;
    public function get named(): String {
        return _named;
    }

    public function get nativePath(): String {
        return getNativePath(File.applicationDirectory.resolvePath(_named));
    }

    private function getNativePath(file:File):String
    {
        // Files located in the Application directory need to be moved so they can be properly read by the ANE.
        // This is due to a bug in AIR that compresses embedded media assets in the Android package, even though
        // the Android documentation states that these assets should not be compressed.
        if(file.nativePath == "")
        {
            var tmpArray:Array = file.url.split('/');
            var filename:String = tmpArray.pop();

            var newFilename:String = filename.replace('/', '_');
            var newFile:File = File.applicationStorageDirectory.resolvePath(newFilename);

            file.copyTo(newFile, true);
            return newFile.nativePath;
        }

        return file.nativePath;
    }

    public function toString(): String {
        return "[NotificationSound(named='"+_named+"')]";
    }
}
}
