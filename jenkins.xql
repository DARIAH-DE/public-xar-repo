xquery version "3.1";

(: this proxy can be called from outside, to trigger a Jenkins job via GET :)

let $job := request:get-parameter("job", "foo")
let $token := request:get-parameter("token", "bar")
let $url := "http://localhost:8080/jenkins/job/"|| encode-for-uri($job) ||"/build?token=" || $token

let $magic := httpclient:get(xs:anyURI($url), false(), ())

return
    (
    xs:integer( $magic/@statusCode ),
    response:set-status-code(xs:integer($magic/@statusCode))
)
