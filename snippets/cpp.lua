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
/******************************************************************************
* Author:           Syed Tamal
* Created:          {} 
******************************************************************************/
#include <bits/stdc++.h>
using namespace std;
#define fastio ios::sync_with_stdio(false); cin.tie(nullptr);
#define int long long

void solve(){{
    {}	
}}

int32_t main(){{
	fastio
	int n;
	cin>>n;
	for(int i=1;i<=n;i++) solve();{}
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
/******************************************************************************
* Author:           Syed Tamal
* Created:          {} 
******************************************************************************/
#include <bits/stdc++.h>
using namespace std;
#define fastio ios::sync_with_stdio(false); cin.tie(nullptr);
#define int long long

int32_t main(){{
	fastio
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

vector<int> bfs(int start, int target = -1){{
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
    vector<int> rank, parent;
public:
    DisjointSet(int n){{
        rank.resize(n+1, 0);
        parent.resize(n+2);
        for(int i=0;i<=n;i++) parent[i] = i;
    }}
    int findUPar(int u){{
        return parent[u] == u ? u : parent[u] = findUPar(parent[u]);
    }}
    void unionByRank(int u, int v){{
        int uP = findUPar(u);
        int vP = findUPar(v);
        if(parent[uP] == parent[vP]) return;
        if(rank[uP] < rank[vP]) parent[uP] = vP;
        else if(rank[uP] > rank[vP]) parent[vP] = uP;
        else parent[vP] = uP, rank[uP]++;
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
            D.unionByRank(it.second.first, it.second.second);
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
int N = 1000005;
vector<bool> is_prime(N+1, true);
void Sieve() {{
    is_prime[0] = is_prime[1] = false;
    for (int i = 2; i <= N; i++) {{
        if (is_prime[i] && (long long)i * i <= N) {{
            for (int j = i * i; j <= N; j += i) is_prime[j] = false;
        }}
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
int Divisors(int n){{
    int sum = 1;
    for(int i=0;i<=N && Prime[i]*Prime[i] <= n; i++){{
        if(n%Prime[i] == 0){{
            int k = 0;
            while(n%Prime[i] == 0) {{
                k++;
                n/=Prime[i];
            }}
            sum *= (k+1);
        }}
    }}
    if(n!=1) sum *= 2;
    return sum;
}}
{}
]],
{
    i(1, ""),
}
))

table.insert(snippets, Divisors);
-- End Refactoring --

return snippets, autosnippets


