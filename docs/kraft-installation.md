# Kraft based installation Notes

## Variables
* **cluster id** should be a valid `guid/uuid` but converted to base64 + 23 characters only.
We can use https://www.fileformat.info/tool/guid-base64.htm or use python

```python
import uuid
import base64

base64.urlsafe_b64encode(uuid.uuid4().bytes).decode("utf-8").strip("=")
```

```bash
$ python3
Python 3.10.6 (main, Nov 14 2022, 16:10:14) [GCC 11.3.0] on linux
>>> import uuid
>>> import base64
>>> base64.urlsafe_b64encode(uuid.uuid4().bytes).decode("utf-8").strip("=")
'8lcyWObISQm7F8E3oahF5w'
```


## References
* https://kafka.apache.org/documentation/#quickstart_startserver
