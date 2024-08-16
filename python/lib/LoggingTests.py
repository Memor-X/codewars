import unittest
from unittest import TestCase
from unittest.mock import Mock, MagicMock, patch

import Logging

outputBuffer = {}
outputBuffer["screen"] = []
def mocked_write(string):
    outputBuffer["screen"].append(string)

@patch('sys.stdout.write', wraps=mocked_write)

class describe_Logging(TestCase):
    def setUp(self):
        global outputBuffer
        outputBuffer = {}
        outputBuffer["screen"] = []

    def test_log(self, a):
        msg = "test log"
        Logging.log(msg)
        self.assertEqual(outputBuffer["screen"][0], "[LOG] " + msg + "\n", "Should append [LOG] to passed string")

    def test_log_warning(self, a):
        msg = "test log"
        Logging.log_warning(msg)
        self.assertEqual(outputBuffer["screen"][0], "[WARNING] " + msg + "\n", "Should append [WARNING] to passed string")

    def test_log_error(self, a):
        msg = "test log"
        Logging.log_error(msg)
        self.assertEqual(outputBuffer["screen"][0], "[ERROR] " + msg + "\n", "Should append [ERROR] to passed string")

    def test_log_success(self, a):
        msg = "test log"
        Logging.log_success(msg)
        self.assertEqual(outputBuffer["screen"][0], "[SUCCESS] " + msg + "\n", "Should append [SUCCESS] to passed string")

    def test_log_debug(self, a):
        msg = "test log"
        Logging.log_debug(msg)
        self.assertEqual(outputBuffer["screen"][0], "[DEBUG] " + msg + "\n", "Should append [DEBUG] to passed string")
    
    def test_log_start(self, a):
        msg = "Script Start"
        Logging.log_start()
        self.assertEqual(outputBuffer["screen"][0], "[LOG] " + msg + "\n", "Should give Script Start Log Message")

    def test_log_end(self, a):
        msg = "Script End"
        Logging.log_end()
        self.assertEqual(outputBuffer["screen"][0], "[SUCCESS] " + msg + "\n", "Should give Script End Success Message")

if __name__ == '__main__':
    unittest.main()
