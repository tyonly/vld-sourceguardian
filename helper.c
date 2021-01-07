#include "zend_execute.h"

// redefining all this due to scope

#define _CONST_CODE  0
#define _TMP_CODE    1
#define _VAR_CODE    2
#define _UNUSED_CODE 3
#define _CV_CODE     4

opcode_handler_t zend_vm_get_opcode_handler(zend_uchar opcode, zend_op* op)
{
               static const int zend_vm_decode[] = {
                        _UNUSED_CODE, /* 0              */
                        _CONST_CODE,  /* 1 = IS_CONST   */
                        _TMP_CODE,    /* 2 = IS_TMP_VAR */
                        _UNUSED_CODE, /* 3              */
                        _VAR_CODE,    /* 4 = IS_VAR     */
                        _UNUSED_CODE, /* 5              */
                        _UNUSED_CODE, /* 6              */
                        _UNUSED_CODE, /* 7              */
                        _UNUSED_CODE, /* 8 = IS_UNUSED  */
                        _UNUSED_CODE, /* 9              */
                        _UNUSED_CODE, /* 10             */
                        _UNUSED_CODE, /* 11             */
                        _UNUSED_CODE, /* 12             */
                        _UNUSED_CODE, /* 13             */
                        _UNUSED_CODE, /* 14             */
                        _UNUSED_CODE, /* 15             */
                        _CV_CODE      /* 16 = IS_CV     */
                };
                return zend_opcode_handlers[opcode * 25 + zend_vm_decode[op->op1_type] * 5 + zend_vm_decode[op->op2_type]];
}
