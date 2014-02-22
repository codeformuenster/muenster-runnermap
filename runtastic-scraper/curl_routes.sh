#!/bin/bash

# if the curl call does not work, use the developer tools in chrome to generate a new curl call

for i in {1..90}
do
  curl "https://www.runtastic.com/en/routes?start_point=true&through_point=false&end_point=true&junction=and&nw_latitude=52.02049803130941&nw_longitude=7.495590676269558&se_latitude=51.90414646576143&se_longitude=7.755829323730495&zoom_level=12&clat=51.96235999999994&clng=7.6257100000000255&distance_min=0&distance_max=300000&elevation_gain_min=0&elevation_gain_max=2500&sport_type_id=1&page=${i}" -H 'Cookie: _runtastic-web_session=BAh7CEkiD3Nlc3Npb25faWQGOgZFRkkiJWY5NmMwNjc1MDZlNDhhNWQ3YjA2ZmMyMGQ3NzBmMTAwBjsAVEkiE3VzZXJfcmV0dXJuX3RvBjsARiIQL2VuL3JvdXRlcz9JIhBfY3NyZl90b2tlbgY7AEZJIjFWVEQ3Qjd4eEw4RE5zbzNxNFlFdFNJMlhSYThYZ1krVEUvYVhKY09wbmZJPQY7AEY%3D--9031ca63f422b327aeb015903e984efd515fe657; runtastic-web=rtvipr-web04; __utma=1.512384459.1393069736.1393069736.1393069736.1; __utmb=1.2.10.1393069736; __utmc=1; __utmz=1.1393069736.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); _mkra_ctxt=0e4e4fd78b50028a839098f05388df6d--302; locale=en' -H 'DNT: 1' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'X-CSRF-Token: VTD7B7xxL8DNso3q4YEtSI2XRa8XgY+TE/aXJcOpnfI=' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: https://www.runtastic.com/en/routes' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --compressed >> "routes_${i}.json"
done


