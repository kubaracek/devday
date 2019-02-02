# MTM-DevDay

## Getting things ready

* **Ruby version**
  * ruby 2.4.1
  * rails 5.1.6
* **System dependencies**
  * rvm (or other ruby version manager) is advised
  * docker
  * docker-compose
* **Configuration**
  * docker-compose up
  * bundle install
* **Database creation**
  * rails db:setup
* **Development**
  * `rails s`
  * go to http://localhost:3000
    * login with email: mail@example.com, password: password
  * go to http://localhost:3000/admin
    * login with email: admin@example.com, password: password
  * This is a known bug with ActiveAdmin and Devise which we just accept for this little testing setup

## Tasks


## Naive Benchmark
 
Make sure you create file `tmp/caching-dev.txt` otherwise caching is disabled

```
require 'benchmark'

request = OpenStruct.new({remote_ip: '127.0.0.1'})
org = Organization.last

#Same User
Benchmark.measure { 1000.times { org.firewall.allow?(request) }}

#New users
Benchmark.measure { 1000.times { org.firewall.allow?(OpenStruct.new(remote_ip: IPAddr.new(rand(2**32),Socket::AF_INET).to_s))} }

```


## My solution

Benchmarking:

* Returning user: firewall adds about 1-2ms overhead to the request
* New ip (that needs to be checked): firewall adds about 2-3ms overhead to the request

Those were benchmarked pretty naivelly on my laptop in the DEVELOPMENT env but the actual realworld result shouldn't
be too off.

There are different approaches to the problem.
From remotely configuring NGINX via middleware to a simple lib.

I've choosen the last option as I was pretty confident in its performance as a
caching can be easily achieved here. Even though no cache is involved the nature
of the problem itself (check if ip matches some conditions) is that it shouldn't
add too much overhead anyway. There are specific problems that could be a bit tricky
to overcome when configuring NGINX remotely or by using a middleware. The
firewall action on ApplicationController just seemed like the easiest,
fastest and most reliable for a dev day.

The whole idea of my implementation is to never ask twice. If a requesters ip is
authorized for a given organization, just store the fact and do not run the
authorization logic again (until a cache is disvalidated). The cache key is
generated in a form of `{ip_address}:{org_id}:whitelist` so if a request
authorization is required I just simply query the cache and return the result.
If cache is nil (first request, cache server down or cache was disvalidated) I
just run the authorization logic.

I originally started with `from..to` ip range validation approach but I realised
that I could use CIDR (Classless Inter-Domain Routing) (192.168.1.1/24) in combination with
standard `NETWORK MASK` (192.168.1.1 255.255.255.0) so it's same as settingup a
firewall on lets say Amazon EC2

To run this, just bundle the project, run
`rake db:create db:migrate db:seed` and play with the ip settings at [Admin IPS](http://localhost:3000/admin/firewall_rules/)
To note: Firewall on an eterprise organization is disabled until there's at
least one firewall rule for a given organization. 
rule.



(Tasks from GDoc be here)
