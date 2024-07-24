namespace java dev.vality.pythagor
namespace erlang pythagor.pythagor

typedef i64 CounterId
typedef string CounterName
typedef string OperationId
typedef i64 Value

exception CounterNotFound {}
exception DuplicateCounterName {}

struct CalculationRequest {
    /* Наименование ИД подсчета */
    1: required CounterName counter_name

    /* ИД операции изменения значения */
    2: required OperationId operation_id

    /* Добавляемое значение */
    3: required Value value
}

struct CalculationResponse {
    /* Внутренний ИД подсчета */
    1: required CounterId id

    /* Наименование ИД подсчета */
    2: required CounterName counter_name

    /* Закоммиченное значение */
    3: required Value commit_value

    /* Захолдирование значение */
    4: required Value hold_value
}

service PythagorService {

    /* Создать счетчик для дальнейшего подсчета */
    CalculationResponse initCounter(CounterName counter_name, OperationId operation_id)
        throws (1: DuplicateCounterName ex1)

    /* Добавить значение */
    CalculationResponse holdValue(CalculationRequest request) throws (1: CounterNotFound ex1)

    /* Применить значение */
    CalculationResponse commitValue(CalculationRequest request) throws (1: CounterNotFound ex1)

    /* Отменить добавление */
    CalculationResponse rollbackValue(CalculationRequest request) throws (1: CounterNotFound ex1)

    /* Добавить и применить значение */
    CalculationResponse addValue(CalculationRequest request) throws (1: CounterNotFound ex1)

    /* Получить значение */
    CalculationResponse getValue(CounterName counter_name) throws (1: CounterNotFound ex1)
}