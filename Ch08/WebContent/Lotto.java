package _0208;

import java.awt.Button;
import java.awt.FlowLayout;
import java.awt.Frame;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.util.Arrays;

import javax.swing.JButton;

public class Lotto extends Frame implements ActionListener{

    String[] str = {"로그인", "회원가입"};
    JButton btn[] = new JButton[6];
    JButton btn1;
	int[] lotto = new int [45];
	int tmp;
	int ran = 0;
	public Lotto() {
		// TODO Auto-generated constructor stub
		super("Lotto 추첨");
	        
        setLayout(new FlowLayout());
        
        for(int i = 0; i < btn.length; i++) {
        	btn[i] = new JButton(""+i);
        }
        btn1 = new JButton("발생");
        for(JButton n : btn){
            add(n);
        }
        add(btn1);
        btn1.addActionListener(this);
        pack();
        setLocation(300,300);
        setVisible(true);
        
		addWindowListener(new WindowAdapter() {
			   @Override
		   public void windowClosing(WindowEvent e) {
		    System.exit(0);
		   }
		});
		
//		for(int i =0 ; i < lotto.length; i++) {
//			lotto[i] = i+1;
//		}
//		for(int i = 0; i < 100; i++) {
//			ran = (int)(Math.random() * 45) ;
//			tmp = lotto[0];
//			lotto[0] = lotto[ran];
//			lotto[ran] = tmp;
//		}
//		for(int i = 0; i < 6; i++) {
//			
//		}
	}

	
	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
//		System.exit(0);
		if(e.getActionCommand() == "발생") {
			for(int i =0 ; i < lotto.length; i++) {
				lotto[i] = i+1;
			}
			for(int i = 0; i < 100; i++) {
				ran = (int)(Math.random() * 45) ;
				tmp = lotto[0];
				lotto[0] = lotto[ran];
				lotto[ran] = tmp;
			}
			for(int i = 0; i < 6; i++) {
//			 btn[i] = new JButton("" + lotto[i]);
			 btn[i].setLabel("" + lotto[i]);
			 System.out.print(lotto[i]);
			}
			
		}
	}
	
	
	public static void main(String[] args) {
		Lotto lt =  new Lotto();
	}
	
}
