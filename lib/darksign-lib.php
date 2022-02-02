<?php

/**
 * Library containing functions for the integration of Darksign.
 */

function restartPiSi()
{
    $addr       = $_SERVER['SERVER_ADDR'];
    $base_url   = 'http://'. $addr .':8000/api/play/playlists/mainpl';
    $action     = ['stop' => true,];
    $curl       = curl_init();

    // set curl options for POST request
    curl_setopt($curl, CURLOPT_URL, $base_url);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_POST, true);
    curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($action));
    curl_setopt($curl, CURLOPT_HTTPHEADER, [
      'Accept: application/json',
      'Authorization: Basic cGk6cGk=',
      'Content-Type: application/json'
    ]);

    // Execute the request and save the response. 
    $json_response  = curl_exec($curl);
    $stop_response  = json_decode($json_response, true);
    $action         = ['play' => true,];

    sleep(3);

    curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($action));

    $play_response  = curl_exec($curl);
}