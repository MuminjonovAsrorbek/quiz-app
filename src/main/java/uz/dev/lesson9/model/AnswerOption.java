package uz.dev.lesson9.model;

import jakarta.persistence.*;
import lombok.*;

/**
 * Created by: asrorbek
 * DateTime: 4/28/25 13:53
 **/

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Table(name = "answer_option")
public class AnswerOption {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String content;

    private Boolean isCorrect;

    @ManyToOne
    @JoinColumn(nullable = false)
    private Question question;
}
