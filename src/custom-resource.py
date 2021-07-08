from __future__ import print_function
from crhelper import CfnResource
import logging

logger = logging.getLogger(__name__)
# Initialise the helper, all inputs are optional, this example shows the defaults
helper = CfnResource(json_logging=False, log_level='DEBUG', boto_level='CRITICAL', sleep_on_delete=120, ssl_verify=None)

try:
    ## Init code goes here
    pass
except Exception as e:
    helper.init_failure(e)

@helper.create
def create(event, context):
    print("Create")

@helper.update
def update(event, context):
    print("Update")

@helper.delete
def delete(event, context):
    print("Delete")

def handler(event, context):
    helper(event, context)