namespace java dev.vality.pythagor
namespace erlang pythagor.pythagor

typedef i64 CalculationId
typedef string CalculationName
typedef string OperationId
typedef i64 Value

exception CalculationNotFound {}

struct CalculationRequest {
    /* Наименование ИД подсчета */
    1: required CalculationName calculation_name

    /* ИД операции изменения значения */
    2: required OperationId operation_id

    /* Добавляемое значение */
    3: required Value value
}

struct CalculationResponse {
    /* Внутренний ИД подсчета */
    1: required CalculationId id

    /* Наименование ИД подсчета */
    2: required CalculationName calculation_name

    /* ИД операции изменения значения */
    3: required OperationId operation_id

    /* Закоммиченное значение */
    4: required Value commit_value

    /* Захолдирование значение */
    5: required Value hold_value
}

service PythagorService {

    /* Добавить значение */
    CalculationResponse hold(CalculationRequest request)

    /* Применить значение */
    CalculationResponse commit(CalculationRequest request) throws (1: CalculationNotFound ex1)

    /* Отменить добавление */
    CalculationResponse rollback(CalculationRequest request) throws (1: CalculationNotFound ex1)

    /* Добавить и применить значение */
    CalculationResponse add(CalculationRequest request)
}