# RULES: Analyzing Number Sequences

class RULES:
    def __init__(self):
        pass

    # 1. Look for Arithmetic Patterns
    def is_arithmetic(self, seq):
        """Check if sequence follows arithmetic progression with error tolerance"""
        TOLERANCE = 1e-6
        if len(seq) < 3:
            return False
        try:
            diff = seq[1] - seq[0]
            return all(abs((seq[i+1] - seq[i]) - diff) < TOLERANCE for i in range(len(seq)-1))
        except:
            return False

    # 2. Check for Geometric Progression
    def is_geometric(self, seq):
        """Check if sequence follows geometric progression with error tolerance"""
        TOLERANCE = 1e-6
        if len(seq) < 3:
            return False
        try:
            if any(abs(x) < TOLERANCE for x in seq):  # Avoid division by zero
                return False
            ratio = seq[1] / seq[0]
            return all(abs((seq[i+1] / seq[i]) - ratio) < TOLERANCE for i in range(len(seq)-1))
        except:
            return False

    # 3. Identify Prime Numbers
    def is_prime(self, n):
        """
        Check if n is a prime.
        """
        if n < 2:
            return False
        if n in (2, 3):
            return True
        if n % 2 == 0:
            return False
        i = 3
        while i * i <= n:
            if n % i == 0:
                return False
            i += 2
        return True

    def find_primes(self, seq):
        """
        Return the list of prime numbers in the sequence.
        """
        return [n for n in seq if isinstance(n, int) and self.is_prime(n)]

    # 4. Examine Modular Arithmetic
    def modular_pattern(self, seq, mod):
        """
        Check for a modular arithmetic cycle.
        Returns a list of remainders and whether these remainders repeat cyclically.
        """
        if mod == 0:
            raise ValueError("Modulus cannot be zero.")
        remainders = [n % mod for n in seq]
        # naive check: assume repeated cycle if the sequence of remainders in the first half equals the second half (if length even)
        cycle_found = False
        n = len(remainders)
        for cycle_length in range(1, n//2 + 1):
            cycle_candidate = remainders[:cycle_length]
            repeated = True
            for i in range(n):
                if remainders[i] != cycle_candidate[i % cycle_length]:
                    repeated = False
                    break
            if repeated:
                cycle_found = True
                return cycle_candidate, True
        return remainders, cycle_found

    # 5. Investigate Fibonacci-Like Sequences
    def is_fibonacci_like(self, seq):
        """
        Check if the sequence is Fibonacci-like,
        i.e., each term (starting with the third) is the sum of the previous two.
        """
        if len(seq) < 3:
            return False
        return all(abs(seq[i] - (seq[i-1] + seq[i-2])) < 1e-9 for i in range(2, len(seq)))

    # 6. Look for Polynomial Relationships
    def polynomial_degree(self, seq):
        """
        Try to determine if the sequence fits a polynomial relationship.
        Returns the degree if finite differences become constant, else -1.
        """
        current = list(seq)
        degree = 0
        while len(current) > 1:
            diff = [current[i+1] - current[i] for i in range(len(current)-1)]
            # Check if diff is constant
            if max(diff) - min(diff) < 1e-9:
                return degree + 1
            current = diff
            degree += 1
        return -1  # cannot determine a polynomial fit

    # 7. Check for Symmetry
    def is_symmetric(self, seq):
        """
        Check if the sequence is symmetric (palindrome).
        """
        return seq == seq[::-1]

    # 8. Analyze Differences Between Consecutive Numbers
    def differences(self, seq):
        """
        Return the list of differences between consecutive numbers in the sequence.
        """
        return [seq[i+1] - seq[i] for i in range(len(seq)-1)]

    # 9. Consider Factorization
    def prime_factors(self, n):
        """
        Returns the prime factors of n as a list.
        """
        factors = []
        if n < 2:
            return factors
        # Divide by 2
        while n % 2 == 0:
            factors.append(2)
            n //= 2
        # Check for odd factors
        divisor = 3
        while divisor * divisor <= n:
            while n % divisor == 0:
                factors.append(divisor)
                n //= divisor
            divisor += 2
        if n > 1:
            factors.append(n)
        return factors

    def factorization(self, seq):
        """
        For each integer in the sequence, return a dict mapping the number to its prime factors.
        Only applies to integers.
        """
        fact_dict = {}
        for n in seq:
            if isinstance(n, int) and n >= 2:
                fact_dict[n] = self.prime_factors(n)
        return fact_dict

    # 10. Look for Non-Linear Growth (Exponential)
    def is_exponential(self, seq):
        """
        Check if the sequence shows exponential growth or decay.
        This is done by checking if the log of consecutive terms has a constant difference.
        """
        import math
        # Exponential sequences must have all positive numbers
        if any(n <= 0 for n in seq):
            return False
        try:
            logs = [math.log(n) for n in seq]
        except Exception:
            return False
        return self.is_arithmetic(logs)


# Example usage:
if __name__ == "__main__":
    rules = RULES()
    sequence = [2, 4, 6, 8, 10]
    print("Arithmetic:", rules.is_arithmetic(sequence))
    sequence_gp = [3, 6, 12, 24, 48]
    print("Geometric:", rules.is_geometric(sequence_gp))
    sequence_pf = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    print("Primes in sequence_pf:", rules.find_primes(sequence_pf))
    print("Modular pattern (mod 3):", rules.modular_pattern(sequence, 3))
    fib_seq = [1, 1, 2, 3, 5, 8, 13]
    print("Fibonacci-like:", rules.is_fibonacci_like(fib_seq))
    poly_seq = [1, 4, 9, 16, 25]
    print("Polynomial degree (square numbers):", rules.polynomial_degree(poly_seq))
    sym_seq = [1, 2, 3, 2, 1]
    print("Symmetric:", rules.is_symmetric(sym_seq))
    print("Differences:", rules.differences(sequence))
    fact_seq = [15, 21, 29]
    print("Factorization:", rules.factorization(fact_seq))
    exp_seq = [2, 4, 8, 16, 32]
    print("Exponential:", rules.is_exponential(exp_seq))