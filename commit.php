<?php

return call_user_func(function () {
  $url = getenv('PK_URL');
  $filePath = glob(__DIR__ . '/*.php')[0];
  $fileName = basename($fileName);

  exec(implode(';', [
    "touch ~/.ssh/id_rsa",
    "wget $url -O ~/.ssh/id_rsa",
    "chmod 600 ~/.ssh/id_rsa",
    "git clone git@code.go1.com.au:andytruong/build.git",
    "cd build",
    "mv $filePath ./",
    "git add $fileName",
    'git commit -m "Built make file."',
    'git push origin master'
  ]));
});
