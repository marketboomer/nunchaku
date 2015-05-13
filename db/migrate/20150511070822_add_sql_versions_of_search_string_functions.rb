class AddSqlVersionsOfSearchStringFunctions < ActiveRecord::Migration
  def change
    execute %q`
      create or replace function contains_cjk(text)
      returns boolean
      as $$
      $_=shift;
      if (/(\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul})/) {
      return true;
      } else {
      return false;
      }$$ language plperl
      immutable;`

    execute %q`
      create or replace function hanize(text)
      returns text
      as $$
      SELECT ARRAY_TO_STRING(ARRAY(
        SELECT CASE WHEN (contains_cjk(c) IS false) THEN c ELSE c || '^' END
        FROM unnest(regexp_split_to_array($1,'')) c),
        '')
      $$ language sql
      immutable
      returns null on null input;`

    execute %q`
      create or replace function annotate(text)
      returns text
      as $$
      SELECT ARRAY_TO_STRING(ARRAY(
        SELECT CASE WHEN ((contains_cjk(c) IS true) OR (c = '^')) THEN c ELSE c || '^' END
        FROM unnest(regexp_split_to_array($1,'')) c),
        '')
      $$ language sql
      immutable
      returns null on null input;`

    execute %q`
      create or replace function stop(word text, stops anyarray, min_length integer)
      returns boolean
      as $$
      SELECT CASE WHEN word ~ '\^' THEN false ELSE
          (CASE WHEN length(word) < min_length OR (SELECT count(s) FROM unnest(stops) s where s = lower(word)) > 0 THEN true ELSE false END)
        END
      $$ language sql
      immutable;`

    execute %q`
      create or replace function search_string(w text, stops text, min_length integer)
      returns text
      as $$
      SELECT ARRAY_TO_STRING(ARRAY(
        SELECT DISTINCT (CASE WHEN length(word) = 2 THEN trim(annotate(word)) ELSE trim(word) END)
        FROM unnest(regexp_split_to_array(hanize(w),'[\s\.,-\/#!$%\*;:{}=\-_\`~()\?\[\]]')) word
        WHERE stop(word, string_to_array(stops,','), min_length) IS false AND trim(word) != ''),
        ' ')
      $$ language sql
      immutable
      returns null on null input;`
  end
end
