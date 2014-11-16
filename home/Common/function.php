<?php
	/**
	 * 下载文件
	 * @param string $file	被下载文件的路径（在public/uploads目录对应下的文件）
	 * @param string $name	用户看到的文件名（不需要加扩展格式）
	 */
	function download($file,$name=''){
	
		$fileName = $name ? $name : pathinfo($file,PATHINFO_FILENAME);
		$filePath = realpath('PUBLIC/Uploads/'.$file);	//固定文件在public/uploads目录下
		$fp = fopen($filePath,'rb');
			
		if(!$filePath || !$fp){
			header('HTTP/1.1 404 Not Found');
			echo "Error: 404 Not Found.(server file path error)<!-- Padding --><!-- Padding --><!-- Padding --><!-- Padding --><!-- Padding --><!-- Padding --><!-- Padding --><!-- Padding --><!-- Padding --><!-- Padding --><!-- Padding --><!-- Padding --><!-- Padding --><!-- Padding -->";
			exit;
		}
			
		$fileName = $fileName .'.'. pathinfo($filePath,PATHINFO_EXTENSION);
		$encoded_filename = urlencode($fileName);
		$encoded_filename = str_replace("+", "%20", $encoded_filename);
	
		header('HTTP/1.1 200 OK');
		header( "Pragma: public" );
		header( "Expires: 0" );
		header("Content-type: application/octet-stream");
		header("Content-Length: ".filesize($filePath));
		header("Accept-Ranges: bytes");
		header("Accept-Length: ".filesize($filePath));
			
		$ua = $_SERVER["HTTP_USER_AGENT"];
		if (preg_match("/MSIE/", $ua)) {
			header('Content-Disposition: attachment; filename="' . $encoded_filename . '"');
		} else if (preg_match("/Firefox/", $ua)) {
			header('Content-Disposition: attachment; filename*="utf8\'\'' . $fileName . '"');
		} else {
			header('Content-Disposition: attachment; filename="' . $fileName . '"');
		}
			
		// ob_end_clean(); <--有些情况可能需要调用此函数
		// 输出文件内容
		fpassthru($fp);
		exit;
	}
	