=begin 
P:
Write a program that can tell you what the nth prime is.
Rules: Do not use Ruby's Prime class nor any of the prime-number testing methods in the Integer class
E:
see tests
D:
  Input = int
  Output = int
A:
   - Check only upto n**1/2, check only primes as factors WHEN DECIDING IF A NUM IS PRIME
   - UNTIL a results_ary is n.size in length DO
    - starting at IF (BASECASE) n==1 return 2
    - IF (BASECASE) n==2 return 3
   - PUSH onto primes_ary the next prime, selected from a filtered range
      - EXCLUDE from the range all even numbers
                              - all multiples of primes in the primes_ary
      - CHECK if is_prime?, push if true

C:
After looking at the video of solutions, it seems the approach could have been done
using (2..Float::Infinity).lazy, without finding the upper_bound
=end

class Prime
  def self.nth(n)
    raise ArgumentError if n <= 0
    primes_ary = [2,3,5,7,11]
    return primes_ary[n-1] if n < 6
    ln = Math.log(n)
    upper_bound = n * (ln + Math.log(ln)) # This is true for n >=6

    (13..Math.celiing(upper_bound)).step(2) do |k|
      return primes_ary.last if primes_ary.size == n
      next if k.to_s.end_with?('0') || k.to_s.end_with?('5')
      primes_ary << k if primes_ary.select{ |p| (p <= k**0.5) && (k % p == 0) }.empty?
    end
  end
end

class Prime
  def self.nth(n)
    


  end

  def is_prime?(n)
    (2..n.pred).each do |k|
      (n % k == 0)

      
      return false unless (n % k == 0)
    end
    true

  end
end