<?php
echo "teste";

die("something bad happened!");

trigger_error("something happened"); //error level is E_USER_NOTICE

//You can control error level
trigger_error("something bad happened", E_USER_ERROR);