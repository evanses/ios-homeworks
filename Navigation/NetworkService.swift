import Foundation

final class NetworkService {
    func getPhotos() throws -> [Photo] {
        
        let makeError = false
        
        if makeError {
            throw PhotoError.cannotCreatePhotos
        }
        
        var list: [Photo] = []
        for i in 0...20 {
            list.append(
                Photo(fileName: "photos/\(i)")
            )
        }
        
        return list
    }
    
    func getPostsData(completion: @escaping (Result<[Post], PostError>) -> Void) {
        let makeError = false
        
        if makeError {
            completion(.failure(.notFound))
        } else {
            
            let posts: [Post] =
            [
                Post(
                    author: "Vaska",
                    description: "Text for post section Blabla",
                    image: "blabla",
                    likes: 2,
                    views: 10
                ),
                Post(
                    author: "Avito Developers",
                    description: "Авито Изображение логотипа Тип Частная компания Основание 2007; 17 лет назад Основатели  Йонас Нордландер Филип Энгельберт Расположение  Россия, Москва, ул. Лесная, дом 7 Ключевые фигуры  Иван Таврин (владелец) Иван Гуз[1] Отрасль классифайд, электронная коммерция Оборот ▲29 млрд ₽ (2020 год) Чистая прибыль ▲10,6 млрд ₽ (2020 год) Число сотрудников  5000 чел. Материнская компания Kismet Capital Group Сайт avito.ru (рус.) Логотип Викисклада Медиафайлы на Викискладе Ави́то — российский интернет-сервис для размещения объявлений о товарах, недвижимости, вакансиях и резюме на рынке труда, а также услугах, занимающий первое место в мире среди сайтов объявлений.",
                    image: "avito",
                    likes: 15,
                    views: 20
                ),
                Post(
                    author: "Aleks",
                    description: "im superman!",
                    image: "superman",
                    likes: 12,
                    views: 13
                ),
                Post(
                    author: "Daria",
                    description: "Бале́т — вид сценического искусства; спектакль, содержание которого воплощается в музыкально-хореографических образах. В основе классического балетного спектакля лежит определённый сюжет, драматургический замысел, либретто, в XX веке появился «бессюжетный» балет, драматургия которого основана на развитии, заложенном в музыке.",
                    image: "ballet",
                    likes: 100,
                    views: 102
                ),
            ]
            
            completion(.success(posts))
        }
    }
}
