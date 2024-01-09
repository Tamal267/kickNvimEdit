local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local func = ls.function_node

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Cpp Snippets", { clear = true })
local file_pattern = "*.cpp"


--All Snippets

local date = function() return {os.date('%d %b %Y  %H:%M:%S')} end

local Date = s("Date", func(date, {}))

local cp = s(
    "cp",
    fmt(
	[[
// Author:           Syed Tamal
// Created:          {} 

#include <bits/stdc++.h>
using namespace std;
#define int long long
#ifdef ONPC
#include "mydebug.h"
#else
#define debug(...) 1
#endif

void solve(){{
	{}	
}}

int32_t main(){{
	ios::sync_with_stdio(false);
	cin.tie(nullptr);
	int n;
	cin>>n;
	for(int i=1;i<=n;i++) {{
	    //cout<<"Case "<<i<<": ";
	    solve();
	}}
	{}
}}
    ]],
	{
	    sn(1, func(date, {})),
	    i(3, ""),
	    i(2, ""),
	}

    )
)

local Cp = s(
    "Cp",
    fmt(
	[[
// Author:           Syed Tamal
// Created:          {} 

#include <bits/stdc++.h>
using namespace std;
#define int long long
#ifdef ONPC
#include "mydebug.h"
#else
#define debug(...) 1
#endif

int32_t main(){{
	ios::sync_with_stdio(false);
	cin.tie(nullptr);
	int n;
	{}
}}
    ]],
	{
	    sn(1, func(date, {})),
	    i(2, ""),
	}

    )
)

-- local if_statement = s("if", fmt(
--     [[
-- if({}){}
--     ]],
-- {
--     i(1, ""),
--     i(2, ""),
-- })
-- )
-- table.insert(autosnippets, if_statement)


local For_satement = s( -- for([%w_]) CPP For Loop snippet{{{
    { trig = "for([%w_])", regTrig = true, hidden = true },
    fmt(
	[[
for(int {} = 0; {} < {}; {}++){{
    {}
}}
    ]],
	{
	d(1, function(_, snip)
		return sn(1, i(1, snip.captures[1]))
	    end),
	    rep(1),
	    c(2, { i(1, "n"), sn(1, { i(1, "arr"), t(".size()") }) }),
	    rep(1),
	    i(3, ""),
	}
    )
) --}}}
-- local While_staement = s( -- [while] CPP While Loop snippet{{{
-- 	"while",
-- 	fmt(
-- 		[[
-- while({}){{
--     {}
-- }}
--   ]],
-- 		{
-- 			i(1, ""),
-- 			i(2, ""),
-- 		}
-- 	)
-- ) --}}}
-- table.insert(autosnippets, For_satement)
-- table.insert(autosnippets, While_staement)
table.insert(snippets, cp)
table.insert(snippets, Cp)
table.insert(snippets, Date)

local bfs_algorithm = s("bfs_algorithm", fmt(
    [[

void bfs(int start, int target = -1){{
	queue<int>q;
	q.push(start);
	vis[start] = true;
	while(!q.empty()){{
		int u = q.front();
		q.pop();
		for(int i:adj[u]){{
			if(!vis[i]){{
				vis[i] = true;
				q.push(i);
			}}
		}}
	}}
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, bfs_algorithm)

local nCr = s("nCr", fmt(
    [[
int inverseMod(int a, int m) {{ return power(a, m - 2); }}

int nCr(int n, int r, int m = mod){{
    if(r==0) return 1;
    if(r>n) return 0;
    return (fact[n] * inverseMod((fact[r] * fact[n-r]) % m , m)) % m;
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, nCr)

local power = s("power", fmt(
    [[
int power(int base, int n, int m = mod){{
    if(n==0) return 1;
    if(n&1) {{
	int x = power(base, n/2);
	return ((x*x) % m * base) % m;
    }}
    else{{
	int x = power(base, n/2);
	return (x*x) % m;
    }}
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, power)

local random = s("random", fmt(
    [[
mt19937_64 rng(chrono::steady_clock::now().time_since_epoch().count());

inline int gen_random(int l, int r) {{
    return uniform_int_distribution<int>(l, r)(rng);
}}

gen_random(l, r);
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, random)

local MOD = s("MOD", {
    t("#define mod "),
    i(1, "1000000007"),
})

table.insert(snippets, MOD)

local DisjointSet = s("DisjointSet", fmt(
    [[
class DisjointSet{{
    vector<int> parent, sz;
public:
    DisjointSet(int n){{
	sz.resize(n+1);
	parent.resize(n+2);
	for(int i=1;i<=n;i++) parent[i] = i, sz[i] = 1;
    }}
    int findUPar(int u){{
	return parent[u] == u ? u : parent[u] = findUPar(parent[u]);
    }}
    void unionBySize(int u, int v){{
	int a = findUPar(u);
	int b = findUPar(v);
	if(sz[a] < sz[b]) swap(a, b);
	if(a != b){{
	    parent[b] = a;
	    sz[a] += sz[b];
	}}
    }}
}};
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, DisjointSet)


local Krushkal = s("Krushkal", fmt(
    [[
vector<pair<int, pair<int, int>>> Krushkal(vector<pair<int, pair<int, int>>> &edges, int n){{
    sort(edges.begin(), edges.end());
    vector<pair<int, pair<int, int>>> ans;
    DisjointSet D(n);
    for(auto it:edges){{
	if(D.findUPar(it.second.first) != D.findUPar(it.second.second)){{
	    ans.push_back({{it.first, {{it.second.first, it.second.second}}}});
	    D.unionBySize(it.second.first, it.second.second);
	}}
    }}
    return ans;
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, Krushkal);

local Prims = s("Prims", fmt(
    [[
void Prims(int start){{
    // map<int, vector<pair<int, int>>> adj, ans;
    priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>> > pq;
    pq.push({{0, {{start, -1}}}});
    while(!pq.empty()){{
	auto it = pq.top();
	pq.pop();
	int wt = it.first;
	int u = it.second.first;
	int v = it.second.second;
	if(vis[u]) continue;
	vis[u] = 1;
	if(v!=-1) ans[u].push_back({{v, wt}});
	for(pair<int, int> i:adj[u]){{
	    int adjWt = i.second;
	    int adjNode = i.first;
	    if(!vis[adjNode]) pq.push({{adjWt, {{adjNode, u}}}});
	}}
    }}
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, Prims);

local MillerRabin = s("MillerRabin", fmt(
    [[
using u64 = uint64_t;
using u128 = __uint128_t;

u64 binpower(u64 base, u64 e, u64 mod) {{
    u64 result = 1;
    base %= mod;
    while (e) {{
	if (e & 1) result = (u128)result * base % mod;
	base = (u128)base * base % mod;
	e >>= 1;
    }}
    return result;
}}

bool check_composite(u64 n, u64 a, u64 d, int s) {{
    u64 x = binpower(a, d, n);
    if (x == 1 || x == n - 1) return false;
    for (int r = 1; r < s; r++) {{
	x = (u128)x * x % n;
	if (x == n - 1) return false;
    }}
    return true;
}};

bool MillerRabin(u64 n, int iter=5) {{ // returns true if n is probably prime, else returns false.
    if (n < 4) return n == 2 || n == 3;
    int s = 0;
    u64 d = n - 1;
    while ((d & 1) == 0) {{
	d >>= 1;
	s++;
    }}

    for (int i = 0; i < iter; i++) {{
	int a = 2 + rand() % (n - 3);
	if (check_composite(n, a, d, s)) return false;
    }}
    return true;
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, MillerRabin);

local Sieve = s("Sieve", fmt(
    [[
const int sieve_size = 10000006;
bitset<sieve_size> sieve;

void Sieve(){{
    sieve.flip();
    int finalBit = sqrt(sieve.size()) + 1;
    for(int i = 2; i < finalBit; ++i){{
	if(sieve.test(i)) for(int j = 2*i; j < sieve_size; j+=i) sieve.reset(j);
    }}
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, Sieve);

local BitManip = s("BitManip", fmt(
    [[
#define SetBit(x, k) (x |= (1LL << k))
#define ClearBit(x, k) (x &= ~(1LL << k))
#define CheckBit(x, k) ((x>>k)&1)
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, BitManip);

local SegmentTree = s("SegmentTree", fmt(
    [[
constexpr int N = 100005;
int arr[N], seg[N];

void build(int ind, int low, int high){{
    if(low == high){{
	seg[ind] = arr[low];
	return ;
    }}
    int mid = (low + high) / 2;
    build(2*ind+1, low, mid);
    build(2*ind+2, mid+1, high);
    seg[ind] = seg[2*ind+1] + seg[2*ind+2];
}}
int query(int ind, int low, int high, int l, int r){{
    if(low >= l && high <= r) return seg[ind];
    if(low > r || high < l) return 0;
    int mid = (low + high) / 2;
    int left = query(2*ind+1, low, mid, l, r);
    int right = query(2*ind+2, mid+1, high, l, r);
    return left + right;
}}
void update(int ind, int low, int high, int node, int val){{
    if(low == high) {{
	seg[ind] = val;
	return;
    }}
    int mid = (low + high) / 2;
    if(low <= node && node <= mid) update(2*ind+1, low, mid, node, val);
    else update(2*ind+2, mid+1, high, node, val);
    seg[ind] = seg[2*ind+1] + seg[2*ind+2];
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, SegmentTree);

local Dijkstra = s("Dijkstra", fmt(
    [[
void Dijkstra(int start){{
    // map<int, vector<pair<int, int>>> adj;
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>> > pq;
    pq.push({{0, start}});
    while(!pq.empty()){{
	auto it = pq.top();
	pq.pop();
	int wt = it.first;
	int u = it.second;
	if(vis[u]) continue;
	vis[u] = 1;
	for(pair<int, int> i:adj[u]){{
	    int adjWt = i.second;
	    int adjNode = i.first;
	    if(dist[adjNode] > wt + adjWt) {{
		dist[adjNode] = wt + adjWt;
		pq.push({{dist[adjNode], adjNode}});
	    }}
	}}
    }}
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, Dijkstra);

local SieveOf = s("SieveOf", fmt(
    [[
constexpr int N = 1000005;

int Prime[N+4], kk;
bool notPrime[N+5];
void SieveOf(){{
    notPrime[1] = true;
    Prime[kk++] = 2;
    for(int i=4;i<=N;i+=2) notPrime[i] = true;
    for(int i=3;i<=N;i+=2){{
	if(!notPrime[i]){{
Prime[kk++] = i;
	    for(int j=i*i; j<=N; j+=2*i) notPrime[j] = true;
	}}
    }}
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, SieveOf);

local Divisors = s("Divisors", fmt(
    [[
constexpr int N = 1000005;

int Prime[N+4], kk;
bool notPrime[N+5];
void SieveOf(){{
    notPrime[1] = true;
    Prime[kk++] = 2;
    for(int i=4;i<=N;i+=2) notPrime[i] = true;
    for(int i=3;i<=N;i+=2){{
        if(!notPrime[i]){{
            Prime[kk++] = i;
            for(int j=i*i; j<=N; j+=2*i) notPrime[j] = true;
        }}
    }}
}}

int Divisors(int n){{
    int sum = 1;
    for(int i=0;i<=N && Prime[i]*Prime[i] <= n; i++){{
        if(n%Prime[i] == 0){{
            int k = 0;
            while(n%Prime[i] == 0) {{
                k++;
                n/=Prime[i];
            }}
            sum *= (k+1);   // NOD
        }}
    }}
    if(n!=1) sum *= 2;
    return sum;
}}
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, Divisors);

local Monotonic_stack = s("Monotonic_stack", fmt(
    [[
for(int i=n-1;i>=0;i--){{
    while(!stk.empty() && v[i] >= v[stk.top()]) stk.pop();
    ind[i] = stk.empty() ? -1 : stk.top();
    stk.push(i);
}}
// 3 1 5 4 10
// 2 2 4 4 -1
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, Monotonic_stack);

local lis = s("lis", fmt(
    [[
void lis(vector<int> &v){{
    int n = v.size();
    vector<int> dp(n+1, 1), hash(n);
    int mx = 1, lastInd = 0;
    for(int i=0;i<n;i++){{
	hash[i] = i;
	for(int prev=0; prev<i;prev++){{
	    if(v[i] > v[prev] && 1 + dp[prev] > dp[i]){{
		dp[i] = 1 + dp[prev];
		hash[i] = prev;
	    }}
	}}
	if(mx < dp[i]){{
	    mx = dp[i];
	    lastInd = i;
	}}
    }}
    vector<int> printSeq;
    printSeq.push_back(v[lastInd]);
    while(hash[lastInd] != lastInd){{
	lastInd = hash[lastInd];
	printSeq.push_back(v[lastInd]);
    }}
    reverse(printSeq.begin(), printSeq.end());
    cout<<mx<<"\n";
    for(int i:printSeq) cout<<i<<" ";
    cout<<"\n";
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, lis);

local lcs = s("lcs", fmt(
    [[
string s,t;
vector<vector<int>>dp(3003, vector<int>(3003, -1));
vector<vector<int>>mark(3003, vector<int>(3003));

int f(int i, int j){{
    if(i<0 || j<0) return 0;
    if(dp[i][j] != -1) return dp[i][j];
    int res = 0;
    if(s[i] == t[j]) {{
	mark[i][j] = 1;
	res = 1 + f(i-1, j-1);
    }}
    else {{
	int iC = f(i-1,j);
	int jC = f(i,j-1);
	if(iC > jC) mark[i][j] = 2;
	else mark[i][j] = 3;
	res = max(iC, jC);
    }}
    return dp[i][j] = res;
}}

void printWay(int i, int j){{
    if(i<0 || j<0) return;
    if(mark[i][j] == 1) printWay(i-1, j-1) , cout<<s[i];
    else if(mark[i][j] == 2) printWay(i-1, j);
    else if(mark[i][j] == 3) printWay(i, j-1);
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, lcs);
-- End Refactoring --


local kmp = s("kmp", fmt(
    [[
vector<int> prefix_function(string s) {{
    int n = (int)s.length();
    vector<int> pi(n);
    for (int i = 1; i < n; i++) {{
        int j = pi[i - 1];
        while (j > 0 && s[i] != s[j]) j = pi[j - 1];
        if (s[i] == s[j]) j++;
        pi[i] = j;
    }}
    return pi;
}}

vector<int> find_matches(string text, string pat) {{
    int n = pat.length(), m = text.length();
    string s = pat + "$" + text;
    vector<int> pi = prefix_function(s), ans;
    for (int i = n; i <= n + m; i++) {{
        if (pi[i] == n) {{
            ans.push_back(i - 2 * n);
        }}
    }}
    return ans;
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, kmp);

local ordered_set = s("ordered_set", fmt(
    [[
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
using namespace __gnu_pbds;
#define ordered_set tree<int, null_type, less<int>, rb_tree_tag, tree_order_statistics_node_update>
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, ordered_set);


local segmentedSieve = s("segmentedSieve", fmt(
    [[
#define mx 100009

vector<int> primes;

void sieveOfEratosthenes() {{
    bool flag[mx + 1];
    for (int i = 0; i <= mx; i++) flag[i] = true;
    primes.push_back(2);

    flag[0] = flag[1] = false;

    for (int i = 4; i <= mx; i += 2) {{
        flag[i] = false;
    }}

    for (int i = 3; i <= mx; i += 2) {{
        if (flag[i] == true)  /// i is prime
	{{
            primes.push_back(i);
            for (int j = i + i; j <= mx; j = j + i) {{
                flag[j] = false;  /// j is not prime
            }}
        }}
    }}
}}

void segmentedSieve(int L, int R) {{
    bool isPrime[R - L + 1];
    for (int i = 0; i <= R - L + 1; i++) isPrime[i] = true;

    if (L == 1) isPrime[0] = false;
    for (int i = 0; primes[i] * primes[i] <= R; i++) {{
        int curPrime = primes[i];
        int base = curPrime * curPrime;
        if (base < L) {{
            base = ((L + curPrime - 1) / curPrime) * curPrime;
        }}
        for (int j = base; j <= R; j += curPrime) isPrime[j - L] = false;
    }}
    for (int i = 0; i <= R - L; i++) {{
        if (isPrime[i] == true) cout << L + i << endl;
    }}
    cout << endl;
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, segmentedSieve);

local pragma = s("pragma", fmt(
    [[
#pragma GCC optimize("Ofast")
#pragma GCC target("avx,avx2,fma")
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, pragma);

local trie = s("trie", fmt(
    [[
const int N = 26;
class Node {{
   public:
    int EoW;
    Node* child[N];
    Node() {{
        EoW = 0;
        for (int i = 0; i < N; i++) child[i] = NULL;
    }}
}};

void insert(Node* node, string s) {{
    for (size_t i = 0; i < s.size(); i++) {{
        int r = s[i] - 'A';
        if (node->child[r] == NULL) node->child[r] = new Node();
        node = node->child[r];
    }}
    node->EoW += 1;
}}

int search(Node* node, string s) {{
    for (size_t i = 0; i < s.size(); i++) {{
        int r = s[i] - 'A';
        if (node->child[r] == NULL) return 0;
    }}
    return node->EoW;
}}

void print(Node* node, string s = "") {{
    if (node->EoW) cout << s << "\n";
    for (int i = 0; i < N; i++) {{
        if (node->child[i] != NULL) {{
            char c = i + 'A';
            print(node->child[i], s + c);
        }}
    }}
}}

bool isChild(Node* node) {{
    for (int i = 0; i < N; i++)
        if (node->child[i] != NULL) return true;
    return false;
}}

bool isJunc(Node* node) {{
    int cnt = 0;
    for (int i = 0; i < N; i++) {{
        if (node->child[i] != NULL) cnt++;
    }}
    if (cnt > 1) return true;
    return false;
}}

int trie_delete(Node* node, string s, int k = 0) {{
    if (node == NULL) return 0;
    if (k == (int)s.size()) {{
        if (node->EoW == 0) return 0;
        if (isChild(node)) {{
            node->EoW = 0;
            return 0;
        }}
        return 1;
    }}
    int r = s[k] - 'A';
    int d = trie_delete(node->child[r], s, k + 1);
    int j = isJunc(node);
    if (d) delete node->child[r];
    if (j) return 0;
    return d;
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, trie);

local ext_gcd = s("ext_gcd", fmt(
    [[
pair<int, int> ext_gcd(int a, int b){{
    if(b == 0){{
        return {{1, 0}};
    }}
    int r = a % b;
    int q = a / b;
    auto pair = ext_gcd(b, r);
    int x = pair.second;
    int y = pair.first - q * pair.second;
    return {{x, y}};
}}
{}
]],
    {
	i(1, ""),
    }
))

table.insert(snippets, ext_gcd);


return snippets, autosnippets


