<?php

use PragmaRX\Support\Exceptions\EnvironmentVariableNotSet;

if ( ! function_exists('env'))
{
	function env($variable)
	{
		$value = getenv($variable);

		if ($value == false)
		{
			throw new EnvironmentVariableNotSet("Environment variable not set: $variable");
		}

		if ($value === '(false)')
		{
			$value = false;
		}
		else
		if ($value === '(null)')
		{
			$value = null;
		}
		else
		if ($value === '(empty)')
		{
			$value = '';
		}

		return $value;
	}

}

if ( ! function_exists('getExecutablePath'))
{
	function getExecutablePath($cmd) 
	{
	    return trim(shell_exec("which $cmd"));
	}
}

if ( ! function_exists('commandExists'))
{
	function commandExists($cmd) 
	{
	    $returnVal = trim(getExecutablePath("which $cmd"));
	    
	    return (empty($returnVal) ? false : true);
	}
}

if ( ! function_exists('removeTrailingSlash'))
{
	function removeTrailingSlash($string)
	{
		return substr($string, -1) == '/' ? substr($string, 0, -1) : $string;
	}
}

if ( ! function_exists('str_contains'))
{
	function str_contains($haystack, $needles)
	{
		foreach ((array) $needles as $needle)
		{
			if ($needle != '' && strpos($haystack, $needle) !== false) return true;
		}

		return false;
	}
}

if ( ! function_exists('is_windows'))
{
	function is_windows()
	{
		return str_contains(strtolower(php_uname()), 'windows');
	}
}

if ( ! function_exists('slash'))
{
	function slash()
	{
		return is_windows()
				? '\\'
				: '/';
	}
}

if ( ! function_exists('explodeTree'))
{
	/**
	 * Explode any single-dimensional array into a full blown tree structure,
	 * based on the delimiters found in it's keys.
	 *
	 * The following code block can be utilized by PEAR's Testing_DocTest
	 * <code>
	 * // Input //
	 * $key_files = array(
	 *   "/etc/php5" => "/etc/php5",
	 *   "/etc/php5/cli" => "/etc/php5/cli",
	 *   "/etc/php5/cli/conf.d" => "/etc/php5/cli/conf.d",
	 *   "/etc/php5/cli/php.ini" => "/etc/php5/cli/php.ini",
	 *   "/etc/php5/conf.d" => "/etc/php5/conf.d",
	 *   "/etc/php5/conf.d/mysqli.ini" => "/etc/php5/conf.d/mysqli.ini",
	 *   "/etc/php5/conf.d/curl.ini" => "/etc/php5/conf.d/curl.ini",
	 *   "/etc/php5/conf.d/snmp.ini" => "/etc/php5/conf.d/snmp.ini",
	 *   "/etc/php5/conf.d/gd.ini" => "/etc/php5/conf.d/gd.ini",
	 *   "/etc/php5/apache2" => "/etc/php5/apache2",
	 *   "/etc/php5/apache2/conf.d" => "/etc/php5/apache2/conf.d",
	 *   "/etc/php5/apache2/php.ini" => "/etc/php5/apache2/php.ini"
	 * );
	 *
	 * // Execute //
	 * $tree = explodeTree($key_files, "/", true);
	 *
	 * // Show //
	 * print_r($tree);
	 *
	 * // expects:
	 * // Array
	 * // (
	 * //    [etc] => Array
	 * //        (
	 * //            [php5] => Array
	 * //                (
	 * //                    [__base_val] => /etc/php5
	 * //                    [cli] => Array
	 * //                        (
	 * //                            [__base_val] => /etc/php5/cli
	 * //                            [conf.d] => /etc/php5/cli/conf.d
	 * //                            [php.ini] => /etc/php5/cli/php.ini
	 * //                        )
	 * //
	 * //                    [conf.d] => Array
	 * //                        (
	 * //                            [__base_val] => /etc/php5/conf.d
	 * //                            [mysqli.ini] => /etc/php5/conf.d/mysqli.ini
	 * //                            [curl.ini] => /etc/php5/conf.d/curl.ini
	 * //                            [snmp.ini] => /etc/php5/conf.d/snmp.ini
	 * //                            [gd.ini] => /etc/php5/conf.d/gd.ini
	 * //                        )
	 * //
	 * //                    [apache2] => Array
	 * //                        (
	 * //                            [__base_val] => /etc/php5/apache2
	 * //                            [conf.d] => /etc/php5/apache2/conf.d
	 * //                            [php.ini] => /etc/php5/apache2/php.ini
	 * //                        )
	 * //
	 * //                )
	 * //
	 * //        )
	 * //
	 * // )
	 * </code>
	 *
	 * @author  Kevin van Zonneveld <kevin@vanzonneveld.net>
	 * @author  Lachlan Donald
	 * @author  Takkie
	 * @copyright 2008 Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	 * @license   http://www.opensource.org/licenses/bsd-license.php New BSD Licence
	 * @version   SVN: Release: $Id: explodeTree.inc.php 89 2008-09-05 20:52:48Z kevin $
	 * @link      http://kevin.vanzonneveld.net/
	 *
	 * @param array   $array
	 * @param string  $delimiter
	 * @param boolean $baseval
	 *
	 * @return array
	 */
	function explodeTree($array, $delimiter = '_', $baseval = false)
	{
	    if (!is_array($array)) return false;
	    $splitRE   = '/' . preg_quote($delimiter, '/') . '/';
	    $returnArr = array();
	    foreach ($array as $key => $val)
	    {
	        // Get parent parts and the current leaf
	        $parts  = preg_split($splitRE, $key, -1, PREG_SPLIT_NO_EMPTY);
	        $leafPart = array_pop($parts);

	        // Build parent structure
	        // Might be slow for really deep and large structures
	        $parentArr = &$returnArr;
	        foreach ($parts as $part)
	        {
	            if (!isset($parentArr[$part]))
	            {
	                $parentArr[$part] = array();
	            } elseif (!is_array($parentArr[$part]))
	            {
	                if ($baseval)
	                {
	                    $parentArr[$part] = array('__base_val' => $parentArr[$part]);
	                } else {
	                    $parentArr[$part] = array();
	                }
	            }
	            $parentArr = &$parentArr[$part];
	        }

	        // Add the final part to the structure
	        if (empty($parentArr[$leafPart]))
	        {
	            $parentArr[$leafPart] = $val;
	        } elseif ($baseval && is_array($parentArr[$leafPart]))
	        {
	            $parentArr[$leafPart]['__base_val'] = $val;
	        }
	    }
	    return $returnArr;
	}
}

if ( ! function_exists('array_get'))
{
	function array_get($array, $key, $default = null)
	{
		if (is_null($key)) return $array;

		if (isset($array[$key])) return $array[$key];

		foreach (explode('.', $key) as $segment)
		{
			if ( ! is_array($array) || ! array_key_exists($segment, $array))
			{
				return value($default);
			}

			$array = $array[$segment];
		}

		return $array;
	}	
}

if ( ! function_exists('value'))
{
	/**
	 * Return the default value of the given value.
	 *
	 * @param  mixed  $value
	 * @return mixed
	 */
	function value($value)
	{
		return $value instanceof Closure ? $value() : $value;
	}
}

if ( ! function_exists('array_pluck'))
{
	/**
	 * Pluck an array of values from an array. (Taylor Otwell)
	 *
	 * @param  array   $array
	 * @param  string  $value
	 * @param  string  $key
	 * @return array
	 */
	function array_pluck($array, $value, $key = null)
	{
		$results = array();

		foreach ($array as $item)
		{
			$itemValue = is_object($item) ? $item->{$value} : $item[$value];

			// If the key is "null", we will just append the value to the array and keep
			// looping. Otherwise we will key the array using the value of the key we
			// received from the developer. Then we'll return the final array form.
			if (is_null($key))
			{
				$results[] = $itemValue;
			}
			else
			{
				$itemKey = is_object($item) ? $item->{$key} : $item[$key];

				$results[$itemKey] = $itemValue;
			}
		}

		return $results;
	}
}

if ( ! function_exists('format_masked'))
{
	function format_masked($val, $mask, $charMask = '9')
	{
		$maskared = '';

		$k = 0;

		for ($i = 0; $i <= strlen($mask)-1; $i++)
		{
			if ($mask[$i] == $charMask)
			{
				if (isset($val[$k]))
				{
					$maskared .= $val[$k++];
				}
			}
			else
			{
				if (isset($mask[$i]))
				{
					$maskared .= $mask[$i];
				}
			}
		}

		return $maskared;
	}
}

if ( ! function_exists('d'))
{
	function d($data = '')
	{
		z($data);
	}
}

if ( ! function_exists('z'))
{
	function z($data = '')
	{
		$cli = php_sapi_name() === 'cli';

		echo $cli ? "" : "<pre>";

		if (is_string($data))
		{
			echo htmlspecialchars($data) . ($cli ? "\n" : "<br>");
		}
		else
		{
			var_dump($data);
		}

		echo $cli ? "" : "</pre>";
	}
}

if ( ! function_exists('dd'))
{
	function dd($data)
	{
		zz($data);
	}
}

if ( ! function_exists('zz'))
{
	function zz($data)
	{
		z($data);

		die;
	}
}

/**
 * For usage check
 *
 *      http://stackoverflow.com/questions/96759/how-do-i-sort-a-multidimensional-array-in-php
 *
 */
if ( ! function_exists('make_comparer'))
{
	function make_comparer()
	{
		// Normalize criteria up front so that the comparer finds everything tidy
		$criteria = func_get_args();
		foreach ($criteria as $index => $criterion)
		{
			$criteria[$index] = is_array($criterion)
				? array_pad($criterion, 3, null)
				: array($criterion, SORT_ASC, null);
		}

		return function ($first, $second) use (&$criteria)
		{
			foreach ($criteria as $criterion)
			{
				// How will we compare this round?
				list($column, $sortOrder, $projection) = $criterion;
				$sortOrder = $sortOrder === SORT_DESC ? -1 : 1;

				// If a projection was defined project the values now
				if ($projection)
				{
					$lhs = call_user_func($projection, $first[$column]);
					$rhs = call_user_func($projection, $second[$column]);
				} else {
					$lhs = $first[$column];
					$rhs = $second[$column];
				}

				// Do the actual comparison; do not return if equal
				if ($lhs < $rhs)
				{
					return -1 * $sortOrder;
				} else if ($lhs > $rhs)
				{
					return 1 * $sortOrder;
				}
			}

			return 0; // tiebreakers exhausted, so $first == $second
		};
	}
}

if ( ! function_exists('array_insert'))
{
	function array_insert(&$array, $insert, $position = -1)
	{
		$array = array_values($array);

		$position = ($position == -1) ? (count($array)) : $position;

		if ($position != (count($array)))
		{
			$ta = $array;

			for ($i = $position; $i < (count($array)); $i++)
			{
				if (!isset($array[$i]))
				{
					die(print_r($array, 1) . "\r\nInvalid array: All keys must be numerical and in sequence.");
				}

				$tmp[$i + 1] = $array[$i];
				unset($ta[$i]);
			}

			$ta[$position] = $insert;
			$array = $ta + $tmp;
			//print_r($array);
		} else {
			$array[$position] = $insert;
		}

		//ksort($array);
		return true;
	}
}

if ( ! function_exists('is_json'))
{
	function is_json($string)
	{
		json_decode($string);

		return (json_last_error() == JSON_ERROR_NONE);
	}
}

if ( ! function_exists('is_xml'))
{
	function is_xml($string)
	{
		$doc = simplexml_load_string($string);

		return ! empty($doc);
	}
}

if ( ! function_exists('xml_to_json'))
{
	function xml_to_json($string)
	{
		$xml = simplexml_load_string($string);

		$json = json_encode($xml);

		return json_decode($json, TRUE);
	}
}

if ( ! function_exists('studly')) {

	/**
	 * Convert a value to studly caps case.
	 *
	 * @param  string $value
	 * @return string
	 */
	function studly($value)
	{
		$value = ucwords(str_replace(array('-', '_'), ' ', $value));

		return str_replace(' ', '', $value);
	}
}

if ( ! function_exists('camel')) {
	/**
	 * Convert a value to camel case.
	 *
	 * @param  string $value
	 * @return string
	 */
	function camel($value)
	{
		return lcfirst(studly($value));
	}
}

if ( ! function_exists('snake')) {

	/**
	 * Convert a string to snake case.
	 *
	 * @param  string $value
	 * @param  string $delimiter
	 * @return string
	 */
	function snake($value, $delimiter = '_')
	{
		$replace = '$1' . $delimiter . '$2';

		return ctype_lower($value) ? $value : strtolower(preg_replace('/(.)([A-Z])/', $replace, $value));
	}
}

if ( ! function_exists('camel')) {
	/**
	 * Convert a value to camel case.
	 *
	 * @param  string $value
	 * @return string
	 */
	function camel($value)
	{
		return lcfirst(studly($value));
	}
}

if ( ! function_exists('array_equal')) {

	function array_equal($a, $b)
	{
		$a = one_dimension_array($a);

		$b = one_dimension_array($b);

		return array_diff($a, $b) === array_diff($b, $a);
	}

}

if ( ! function_exists('one_dimension_array')) 
{

	function one_dimension_array($array)
	{
		$it =  new \RecursiveIteratorIterator(new \RecursiveArrayIterator($array));

		return iterator_to_array($it, false);
	}

}

if ( !function_exists( 'array_implode' )) 
{
	function array_implode( $glue, $separator, $array ) 
	{
		if ( ! is_array( $array ) )
		{
			return $array;
		}
	 
		$string = array();
	 
		foreach ( $array as $key => $val ) 
		{
			if ( is_array( $val ) )
			{
				$val = implode( ',', $val );
			}

			$string[] = "{$key}{$glue}{$val}";
		}
		return implode( $separator, $string );
	}
}

if ( !function_exists( 'get_ipv4_range' )) {
	/**
	 *
	 *get the first ip and last ip from cidr(network id and mask length)
	 * i will integrate this function into "Rong Framework" :)
	 * @author admin@wudimei.com
	 * @param string $cidr 56.15.0.6/16 , [network id]/[mask length]
	 * @return array $ipArray = array( 0 =>"first ip of the network", 1=>"last ip of the network" );
	 *                         Each element of $ipArray's type is long int,use long2ip( $ipArray[0] ) to convert it into ip string.
	 * example:
	 * list( $long_startIp , $long_endIp) = get_ipv4_range( "56.15.0.6/16" );
	 * echo "start ip:" . long2ip( $long_startIp );
	 * echo "<br />";
	 * echo "end ip:" . long2ip( $long_endIp );
	 */

	function get_ipv4_range($cidr)
	{

		list($ip, $mask) = explode('/', $cidr);

		$maskBinStr = str_repeat("1", $mask) . str_repeat("0", 32 - $mask); //net mask binary string
		$inverseMaskBinStr = str_repeat("0", $mask) . str_repeat("1", 32 - $mask); //inverse mask

		$ipLong = ip2long($ip);
		$ipMaskLong = bindec($maskBinStr);
		$inverseIpMaskLong = bindec($inverseMaskBinStr);
		$netWork = $ipLong & $ipMaskLong;

		$start = $netWork + 1; //去掉网络号 ,ignore network ID(eg: 192.168.1.0)

		$end = ($netWork | $inverseIpMaskLong) - 1; //去掉广播地址 ignore brocast IP(eg: 192.168.1.255)
		return array($start, $end);
	}
}

if ( !function_exists( 'ipv4_match_mask' ))
{
	function ipv4_match_mask($ip, $network)
	{
		// Determines if a network in the form of
		//   192.168.17.1/16 or
		//   127.0.0.1/255.255.255.255 or
		//   10.0.0.1
		// matches a given ip
		$ipv4_arr = explode('/', $network);

		if (count($ipv4_arr) == 1)
		{
			$ipv4_arr[1] = '255.255.255.255';
		}

		$network_long = ip2long($ipv4_arr[0]);

		$x = ip2long($ipv4_arr[1]);
		$mask =  long2ip($x) == $ipv4_arr[1] ? $x : 0xffffffff << (32 - $ipv4_arr[1]);
		$ipv4_long = ip2long($ip);

		return ($ipv4_long & $mask) == ($network_long & $mask);
	}
}

if ( !function_exists( 'ipv4_in_range' ))
{
	function ipv4_in_range($ip, $range)
	{
		if (is_array($range))
		{
			foreach ($range as $iprange)
			{
				if (ipv4_in_range($ip, $iprange))
				{
					return true;
				}
			}

			return false;
		}

		// Dashed range
		//   192.168.1.1-192.168.1.100
		//   0.0.0.0-255.255.255.255
		if (count($twoIps = explode('-', $range)) == 2)
		{
			$ip1 = ip2long($twoIps[0]);
			$ip2 = ip2long($twoIps[1]);

			return ip2long($ip) >= $ip1 && ip2long($ip) <= $ip2;
		}

		// Masked range or fixed IP
		//   192.168.17.1/16 or
		//   127.0.0.1/255.255.255.255 or
		//   10.0.0.1
		return ipv4_match_mask($ip, $range);
	}
}
