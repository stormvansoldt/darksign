<?php

/**
 * Library containing functions for the integration of Darksign.
 */

function restartPiSi()
{
  $base_url   = 'http://'. $_SERVER['SERVER_ADDR'] .':8000/api/play/playlists/mainpl';
  $curl       = curl_init();

  // set curl options for POST request
  curl_setopt($curl, CURLOPT_URL, $base_url);
  curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($curl, CURLOPT_POST, true);
  curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode(['stop' => true,]));
  curl_setopt($curl, CURLOPT_HTTPHEADER, [
    'Accept: application/json',
    'Authorization: Basic cGk6cGk=',
    'Content-Type: application/json'
  ]);

  // Execute the request and save the response. 
  curl_exec($curl);
  sleep(1);
  
  curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode(['play' => true,]));
  curl_exec($curl);
}