" Vim syntax file
" Language:	SQL, PL/SQL (Oracle 11g)
" Maintainer:	Alvin Steele <steelea AT acm.org>
" Last Change:	2008 Sep 04

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
" prior version Maintainer:	Paul Moore <pf_moore AT yahoo.co.uk>
" prior version Last Change:	2005 Dec 23
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

" The SQL reserved words, defined as keywords.

syn keyword sqlSpecial  false null true

syn keyword sqlKeyword	access add as asc begin by case check cluster column
syn keyword sqlKeyword	compress connect connect_by_iscycle connect_by_isleaf 
syn keyword sqlKeyword  current cursor decimal default desc
syn keyword sqlKeyword	else elsif end exception exclusive file for from
syn keyword sqlKeyword	function group having identified if immediate increment
syn keyword sqlKeyword	index initial into is level loop maxextents mode modify
syn keyword sqlKeyword	nocompress nowait of offline on online order over partition
syn keyword sqlKeyword	start successful synonym table then to trigger uid
syn keyword sqlKeyword	unique user validate values view when whenever
syn keyword sqlKeyword	where with option order pctfree privileges procedure
syn keyword sqlKeyword	public resource return row rowlabel rownum rows
syn keyword sqlKeyword	session share size smallint type using
syn keyword sqlKeyword	column_value object_id object_value ora_rowscn rowid
syn keyword sqlKeyword	xmldata currval nextval versions_starttime versions_startscn
syn keyword sqlKeyword	versions_endtime versions_endscn versions_xid versions_operation


syn keyword sqlOperator	not and or
syn keyword sqlOperator	in any some all between exists
syn keyword sqlOperator	like escape
syn keyword sqlOperator union intersect minus
syn keyword sqlOperator prior distinct nocycle
syn keyword sqlOperator	sysdate out connect_by_root multiset except
syn keyword sqlOperator submultiset regexp_like equals_path under_path 
syn keyword sqlOperator present empty member	

syn keyword sqlStatement alter analyze audit comment commit create
syn keyword sqlStatement delete drop execute explain grant insert lock merge noaudit
syn keyword sqlStatement rename revoke rollback savepoint select set
syn keyword sqlStatement truncate update

syn keyword sqlType	boolean char character date float integer long
syn keyword sqlType	mlslabel number raw rowid varchar varchar2 varray

syn keyword sqlFunction  abs acos add_months appendchildxml asciistr
syn keyword sqlFunction  ascii asin atan atan2 avg
syn keyword sqlFunction  bfilename bin_to_num bitand cardinality cast
syn keyword sqlFunction  ceil chartorowid chr cluster_id cluster_probability
syn keyword sqlFunction  cluster_set coalesce collect compose concat
syn keyword sqlFunction  convert corr corr_s corr_k cos
syn keyword sqlFunction  cosh count covar_pop covar_samp cube_table
syn keyword sqlFunction  cume_dist current_date current_timestamp cv dataobj_to_partition
syn keyword sqlFunction  dbtimezone decode decompose deletexml dense_rank
syn keyword sqlFunction  depth deref dump empty_blob empty_clob
syn keyword sqlFunction  existsnode exp extract extractvalue feature_id
syn keyword sqlFunction  feature_set feature_value first first_value floor
syn keyword sqlFunction  from_tz greatest group_id grouping grouping_id
syn keyword sqlFunction  hextoraw initcap insertchildxml insertxmlbefore instr
syn keyword sqlFunction  iteration_number lag last last_day last_value
syn keyword sqlFunction  lead least length ln lnnvl
syn keyword sqlFunction  localtimestamp log lower lpad ltrim
syn keyword sqlFunction  make_ref max median min mod
syn keyword sqlFunction  months_between nanvl nchr new_time next_day
syn keyword sqlFunction  nls_charset_decl_len nls_charset_id nls_charset_name nls_initcap nls_lower
syn keyword sqlFunction  nlssort nls_upper ntile nullif numtodsinterval
syn keyword sqlFunction  numtoyminterval nvl nvl2 ora_hash path
syn keyword sqlFunction  percent_rank percentile_cont percentile_disc power powermultiset
syn keyword sqlFunction  powermultiset_by_cardinality prediction prediction_bounds prediction_cost prediction_details
syn keyword sqlFunction  prediction_probability prediction_set presentnnv presentv previous
syn keyword sqlFunction  rank ratio_to_report rawtohex rawtonhex ref
syn keyword sqlFunction  reftohex regexp_count regexp_instr regexp_replace regexp_substr
syn keyword sqlFunction  regr_slope regr_intercept regr_count regr_r2 regr_avgx
syn keyword sqlFunction  regr_avgy regr_sxx regr_syy regr_sxy remainder
syn keyword sqlFunction  replace round row_number rowidtochar rowidtonchar
syn keyword sqlFunction  rpad rtrim scn_to_timestamp sessiontimezone set
syn keyword sqlFunction  sign sin sinh soundex sqrt
syn keyword sqlFunction  stats_binomial_test stats_crosstab stats_f_test stats_ks_test stats_mode
syn keyword sqlFunction  stats_mw_test stats_one_way_anova stats_t_test_one stats_t_test_paired stats_t_test_indep stats_t_test_indepu
syn keyword sqlFunction  stats_wsr_test stddev stddev_pop stddev_samp substr
syn keyword sqlFunction  sum sys_connect_by_path sys_context sys_dburigen sys_extract_utc
syn keyword sqlFunction  sys_guid sys_typeid sys_xmlagg sys_xmlgen sysdate
syn keyword sqlFunction  systimestamp tan tanh timestamp_to_scn to_binary_double
syn keyword sqlFunction  to_binary_float to_char to_clob to_date to_dsinterval
syn keyword sqlFunction  to_lob to_multi_byte to_nchar to_nclob to_number
syn keyword sqlFunction  to_single_byte to_timestamp to_timestamp_tz to_yminterval translate
syn keyword sqlFunction  treat trim trunc tz_offset
syn keyword sqlFunction  uid unistr updatexml upper user
syn keyword sqlFunction  userenv value var_pop var_samp variance
syn keyword sqlFunction  vsize width_bucket xmlagg xmlcast xmlcdata
syn keyword sqlFunction  xmlcolattval xmlcomment xmlconcat xmldiff xmlelement
syn keyword sqlFunction  xmlexists xmlforest xmlparse xmlpatch xmlpi
syn keyword sqlFunction  xmlquery xmlroot xmlsequence xmlserialize xmltable
syn keyword sqlFunction  xmltransform

" Strings and characters:
syn region sqlString		start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region sqlString		start=+'+  skip=+\\\\\|\\'+  end=+'+

" Numbers:
syn match sqlNumber		"-\=\<\d*\.\=[0-9_]\>"

" Comments:
syn region sqlComment    start="/\*"  end="\*/" contains=sqlTodo
syn match sqlComment	"--.*$" contains=sqlTodo

syn sync ccomment sqlComment

" Todo.
syn keyword sqlTodo contained TODO FIXME XXX DEBUG NOTE

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_sql_syn_inits")
  if version < 508
    let did_sql_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink sqlComment	Comment
  HiLink sqlKeyword	sqlSpecial
  HiLink sqlNumber	Number
  HiLink sqlOperator	sqlStatement
  HiLink sqlSpecial	Special
  HiLink sqlStatement	Statement
  HiLink sqlString	String
  HiLink sqlType	Type
  HiLink sqlTodo	Todo
  HiLink sqlFunction	Function

  delcommand HiLink
endif

let b:current_syntax = "sql"

" vim: ts=8
