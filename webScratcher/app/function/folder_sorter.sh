

# if by the params no path has been specified by the command give a option to also chose a folder on the users pc prompt a file picker 

curl -X POST http://127.0.0.1:8000 \
 -H "Content-Type: application/json" \
 -d '{"path": "../../res/**", "instruction": "string", "incognito": false}'
