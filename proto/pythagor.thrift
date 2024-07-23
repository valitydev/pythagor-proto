namespace java dev.vality.pythagor
namespace erlang pythagor.pythagor

typedef i64 CalculationId
typedef string CalculationName
typedef string OperationId
typedef i64 Value

exception CalculationNotFound {}

struct CalculationResponse {
    1: required CalculationId id
    2: required CalculationName calculation_name
    3: required OperationId operation_id
    4: required Value commit_value
    5: required Value hold_value
}

service PythagorService {

    /* Добавить и применить значение */
    CalculationResponse add(CalculationName calculation_name, OperationId operation_id, Value value)

    /* Добавить значение */
    CalculationResponse hold(CalculationName calculation_name, OperationId operation_id, Value value)
        throws (1: CalculationNotFound ex1)

    /* Применить значение */
    CalculationResponse commit(CalculationName calculation_name, OperationId operation_id, Value value)
        throws (1: CalculationNotFound ex1)

    /* Отменить добавление */
    CalculationResponse rollback(CalculationName calculation_name, OperationId operation_id, Value value)
        throws (1: CalculationNotFound ex1)

}