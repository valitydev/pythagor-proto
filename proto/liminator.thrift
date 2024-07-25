namespace java dev.vality.liminator
namespace erlang liminator.liminator

typedef i64 LimitId
typedef string LimitName
typedef string OperationId
typedef i64 Value
typedef i64 Timestamp

exception CounterNotFound {}
exception DuplicateCounterName {}

struct LimitRequest {
    /* Наименование ИД подсчета */
    1: required LimitName limit_name

    /* ИД операции изменения значения */
    2: required OperationId operation_id

    /* Добавляемое значение */
    3: required Value value

    /* Добавляемое значение */
    4: required Timestamp timestamp
}

struct LimitResponse {
    /* Внутренний ИД подсчета */
    1: required LimitId id

    /* Наименование ИД подсчета */
    2: required LimitName limit_name

    /* Закоммиченное значение */
    3: required Value commit_value

    /* Захолдирование значение */
    4: required Value hold_value
}

service LiminatorService {

    /* Создать счетчик для дальнейшего подсчета */
    LimitResponse initLimit(LimitName limit_name, OperationId operation_id)
        throws (1: DuplicateCounterName ex1)

    /* Добавить значение */
    list<LimitResponse> hold(list<LimitRequest> request) throws (1: CounterNotFound ex1)

    /* Применить значение */
    list<LimitResponse> commitValue(list<LimitRequest> request) throws (1: CounterNotFound ex1)

    /* Отменить добавление */
    list<LimitResponse> rollbackValue(list<LimitRequest> request) throws (1: CounterNotFound ex1)

    /* Получить значение */
    list<LimitResponse> getLimits(list<LimitName> limit_name) throws (1: CounterNotFound ex1)
}