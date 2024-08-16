# loading Unit Test
import unittest
from unittest import TestCase
from unittest.mock import Mock, MagicMock, patch

# Loading LocalLib Library
import LocalLib

# Setting up sys.stdout.write mock and output buffer
outputBuffer = {}
outputBuffer["screen"] = []
def mocked_write(string):
    outputBuffer["screen"].append(string)
@patch('sys.stdout.write', wraps=mocked_write)

# Tests
class describe_likes(TestCase):
    
    # Clears the output buffer after every test
    def setUp(self):
        global outputBuffer
        outputBuffer = {}
        outputBuffer["screen"] = []

    def test_no_likes(self, a):
        self.assertEqual(LocalLib.likes([]), 'no one likes this')

    def test_one_like(self, a):
        self.assertEqual(LocalLib.likes(['Peter']), 'Peter likes this')
    
    def test_two_likes(self, a):
        self.assertEqual(LocalLib.likes(['Jacob', 'Alex']), 'Jacob and Alex like this')

    def test_three_likes(self, a):
        self.assertEqual(LocalLib.likes(['Max', 'John', 'Mark']), 'Max, John and Mark like this')
    
    def test_four_likes(self, a):
        self.assertEqual(LocalLib.likes(['Alex', 'Jacob', 'Mark', 'Max']), 'Alex, Jacob and 2 others like this')

if __name__ == '__main__':
    unittest.main()
